//
//  ControlsView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    
    var body: some View {
        
        ZStack {
            //background
            Image("BACKGROUND-DARK-2")
            
            
            //exit button
            Button {
                workoutManager.endWorkout() 
            } label: {
                Image("Exit")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 136.11, height: 49)
            }
            .buttonStyle(PlainButtonStyle())
        }
        
    }
}

#Preview {
    ControlsView()
}
