//
//  MetricsView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            //active energy measurement text field --> ambil data dari workoutManager
            Text(
                Measurement(
                    value: workoutManager.activeEnergy,
                    unit: UnitEnergy.kilocalories
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout,
                        numberFormatStyle: .number.precision(.fractionLength(0))
                    )
                )
            )

            
            //heart rate text field --> ambil data dari workoutManager

            Text(
                workoutManager.heartRate.formatted(
                    .number.precision(.fractionLength(0))
                )
                + "bpm"
                
            )
            
            //distance text view --> ambil data dari workoutManager
            Text(
                Measurement(
                    value: workoutManager.distance,
                    unit: UnitLength.meters
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .road
                    )
                )
                
            )
            
            //Running pace text view --> ambil data dari workoutManager
            Text(
                Measurement(
                    value: workoutManager.runningPace,
                    unit: UnitSpeed.metersPerSecond
                ).paceformatted
            )
            
            
        }//end of vstack
        
        .font(.system(size: 25, weight: .regular, design: .rounded) .monospaced() . lowercaseSmallCaps())
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
        




    }
}

#Preview {
    MetricsView()
}


extension Measurement where UnitType: UnitSpeed { //extension for unitspeed
    var paceformatted: String {
        let valueFormatter = NumberFormatter()
        valueFormatter.maximumFractionDigits = 1
        valueFormatter.minimumFractionDigits = 1
        
        
        let paceformatted = MeasurementFormatter() //format measurement values into strings.
        paceformatted.unitOptions = .providedUnit //UnitSpeed.minutesPerKilometer
        paceformatted.unitStyle = .short //abbreviated units
        
        
        let valueString = valueFormatter.string(from: NSNumber(value: self.value)) ?? ""
        let unitString = paceformatted.string(from: self.unit)
        
        return "\(valueString) \(unitString)"

    }
}

