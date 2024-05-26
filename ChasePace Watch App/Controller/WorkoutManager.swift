//  WorkoutManager.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject{
    
   
    var selectedWorkout: HKWorkoutActivityType?{
        didSet {
            guard let selectedWorkout = selectedWorkout else {return}
            startWorkout(workoutType: selectedWorkout)
        }
    }
    

    @Published var showingGameOverView: Bool = false {
        didSet {
            if showingGameOverView == false{
                resetWorkout()
            }
        }
    }
    
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    

    private let targetRunningPace: Double = 4.0 // Target running pace (m/s)
    private let loseRunningPace: Double = 3.5 // Lose running pace condition (m/s)
    private let targetDistance: Double = 200 // Target distance in meters
    
    
    
    //start HKWorkoutSession and HKLiveWorkoutBuilder when level is selected
    func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running 
        configuration.locationType = .outdoor
        
        //create a workout session using HKWorkoutSession.
        do{
            // initializes the workout session
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            
            //allows the app to add samples (e.g., heart rate, distance) to the workout.
            builder = session?.associatedWorkoutBuilder()
        }catch {
            return
        }
        
        
       //sets up real-time data collection for a workout session using HealthKit
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        session?.delegate = self
        builder?.delegate = self
        
        //start workout session and begin data collection
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate){(success, error) in
            //workout started
        }
    }
    
    
    
    //Request authorization to access HealthKit
    func requestAuthorization() {
        //quantity type to write to health store
        let typesToShare: Set = [
            HKQuantityType.workoutType() 
        ]
        
        //quantity types to read form health store
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .runningSpeed)!
        ]
        
        
        //Request authorization for quantity types
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead){
            (success, error) in
            //handle error
        }
        
        
    }
    
    // MARK: -State Control
    
    //the workout session state
    @Published var running = false
    
    //end the session
    func endWorkout(){
        session?.end()
        showingGameOverView = true
        HapticFeedbackManager.shared.stopHapticFeedback()
    }
    
    
    //MARK: - Workout Metrics
    //For metricsView
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var distance: Double = 0
    @Published var runningPace: Double = 0

    
    //variable to save data when finished(?)
    @Published var workout: HKWorkout?
    
    //update stat in metricViews
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }

        DispatchQueue.main.async {
            switch statistics.quantityType {
            
            //Heart rate --> beats/minute
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                //beats/minute formula
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                
                
            //active energy burned
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                //formula
                let energyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            
                
            //Distance for running
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning), HKQuantityType.quantityType(forIdentifier: .distanceCycling):
                //formula
                let meterUnit = HKUnit.meter()
                self.distance = statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0
                
                //codition --> menang
                if self.distance >= self.targetDistance {
                    HapticFeedbackManager.shared.playEndHapticFeedback()
                    self.endWorkout()
                    return
                }

                
                
            //running pace --> speed m/s
            case HKQuantityType.quantityType(forIdentifier: .runningSpeed):
                // formula
                let speedUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
                let speedInMetersPerSecond = statistics.mostRecentQuantity()?.doubleValue(for: speedUnit) ?? 0
                self.runningPace = speedInMetersPerSecond
                
                //codition --> kalah
                if self.runningPace < self.loseRunningPace {
                    HapticFeedbackManager.shared.playEndHapticFeedback()
                    self.endWorkout()
                    return
                }
                            
                //codition user pace < target pace
                if self.runningPace < self.targetRunningPace {
                    HapticFeedbackManager.shared.startContinuousHapticFeedback()
                } else {
                    HapticFeedbackManager.shared.stopHapticFeedback()
                }
                
            default:
                return
            }
        }
    }
    
    //reset function --> after button restart
    func resetWorkout(){
        selectedWorkout = nil
        builder = nil
        session = nil
        workout = nil
        
        activeEnergy = 0
        heartRate = 0
        distance = 0
        runningPace = 0
        
        HapticFeedbackManager.shared.stopHapticFeedback()

        
    }


    
    
    
}

// MARK: -HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    
    //function called whenever the state changes
    func workoutSession(_ workoutSession: HKWorkoutSession,
                        didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, 
                        date: Date) {
        
        DispatchQueue.main.async {
            self.running = toState == .running
        }

        // Wait for the session to transition states before ending the builder.
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                self.builder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async{
                        self.workout = workout
                    }
                }
            }
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {

    }
    
}

// MARK: -HKLiveWorkoutBuilderDelegate
extension WorkoutManager: HKLiveWorkoutBuilderDelegate{
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {return}
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            //update the publish values
            updateForStatistics(statistics)
        }
    }
}

