//
//  ChasePaceApp.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

@main
struct ChasePace_Watch_AppApp: App {
    
    //give views access to WorkoutManager
    //    @StateObject var workoutManager = WorkoutManager()
    //
    //    @SceneBuilder var body: some Scene {
    //        WindowGroup {
    //            NavigationView {
    //                StartView()
    //            }
    //
    //            .sheet(isPresented: $workoutManager.showingSummaryView){
    //                SummaryView()
    //            }
    //
    //            .environmentObject(workoutManager)
    //        }
    //    }
    //}
    
    
    var body: some Scene {
        WindowGroup {
            GameView()
        }
    }
    
    
}

