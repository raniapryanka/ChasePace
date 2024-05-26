//
//  SessionPagingView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

//Tab view layout
//to access page controlView and gameS=cene (game play page)

struct SessionPagingView: View {
    
    //page metrics muncul duluan --> GamePlay page
    @State private var selection: Tab = .metrics
    
    //ke page controls and workout metrics
    enum Tab {
        case controls, metrics
    }
    
    
    var body: some View {
        
        //PAGE CAROUSEL(exit page, workout metric)
        TabView(selection: $selection) {
            
            //page control (Exit)
            ControlsView().tag(Tab.controls)
            
            //page workout metric --> nanti ganti gameScene page
            MetricsView().tag(Tab.metrics)
        }
        
    }
}

#Preview {
    SessionPagingView()
}
