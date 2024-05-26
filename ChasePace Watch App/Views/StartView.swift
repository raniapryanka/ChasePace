//
//  ContentView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI
import HealthKit


struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    
    var body: some View {
        ZStack {
            
            //background
            Image("BACKGROUND-main")
            
            VStack {
                //easy
                    NavigationLink(
                        destination: CountDownView(),
                        tag: .running,
                        selection: $workoutManager.selectedWorkout
                    ) {
                        Image("easy")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 136.11, height: 49)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(Color.clear)
                
                    Spacer().frame(height: 12)

                
                //medium
                    NavigationLink(
                        destination: CountDownView(),
                        tag: .running,
                        selection: $workoutManager.selectedWorkout
                    ) {
                        Image("medium")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 136.11, height: 49)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(Color.clear)
                
                
                Spacer().frame(height: 12)

            
            //hard
                NavigationLink(
                    destination: CountDownView(),
                    tag: .running,
                    selection: $workoutManager.selectedWorkout
                ) {
                    Image("hard")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 136.11, height: 49)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.clear)

            }
            
            .onAppear {
                workoutManager.requestAuthorization()
            }
            
            
            
            
        }
        
        
        
        
        
    }
    
    
}
    


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

