//
//  SummaryView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    
    //date composed formatter
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    
    var body: some View {
        @Environment(\.presentationMode) var presentationMode

        
        
        if workoutManager.workout == nil{
            ProgressView("Loading")
                .navigationBarHidden(true)
        }else{
            //Game over
            ZStack{
                //background
                Image("BACKGROUND-DARK-3")

                
                    VStack{
                        VStack(spacing: 5){
                            Text("Game")
                                .font(.custom("Pixeled", size: 30))
                            
                            Text("Over")
                                .font(.custom("Pixeled", size: 30))
                                .padding(.top, -45)
                            
                            Button{
                                dismiss()
                            }label: {
                                Image("Restart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 136.11, height: 49)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Spacer()
                        
                    } .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarHidden(true)
        }
        
       
            
        
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}


