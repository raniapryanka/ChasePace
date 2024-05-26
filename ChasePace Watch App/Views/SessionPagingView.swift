//
//  SessionPagingView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI
import WatchKit


struct SessionPagingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .game //page yang muncul duluan --> GameView page

    enum Tab {
        case controls, game, metrics
    }
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            //page control (Exit)
            ControlsView().tag(Tab.controls)
            
            //GameView --> GameScene
            GameView().tag(Tab.game)
            
            //page workout metric --> nanti ilangin
            MetricsView().tag(Tab.metrics)
        }
        
        .navigationBarBackButtonHidden(true)
        .onChange(of: workoutManager.running) {
            displayMetricsView()
        }
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
    
    
    
}

#Preview {
    SessionPagingView()
}
