//
//  ContentView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI
import HealthKit


//StartView (Main Menu)

struct StartView: View {
    //add array of workout types based on the HKWorkoutActivityType --> Running
    var workoutTypes: [HKWorkoutActivityType] = [.running, .cycling]
    
    
    var body: some View {
        //=========DESIGN UI HERE===========
        
        
       //BUTTON VIEW --> link to main page (metricView/GameScene)
        List(workoutTypes) { workoutTypes in 
            NavigationLink(
                workoutTypes.name,
                destination: SessionPagingView() //ke page tab view (ControlsView and GameScene)
            ).padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
        } 
        .listStyle(.carousel) //depth effect when scrolling
        .navigationBarTitle("Workouts") //title
        
        
        
    }
}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
            
        //main button chasepace
        case .running:
            return "Play"
            
        //nanti hapus
        case .cycling:
            return "Bike"
        default:
            return ""
        }
    }
}
