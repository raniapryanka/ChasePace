//
//  CountDownView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 24/05/24.
//

import SwiftUI

struct CountDownView: View {
    
    @State private var currentCount = 0
    let countdownTexts = ["Ready", "Ready", "3", "2", "1", "Run!"]
    
    @State private var countdownFinished = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        NavigationStack{
            ZStack {
                Image("BACKGROUND-DARK-2")
                
                Text(countdownTexts[currentCount])
                    .font(.custom("Pixeled", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, -45)
                
                    .onReceive(timer) { _ in
                        if self.currentCount < self.countdownTexts.count - 1 {
                            self.currentCount += 1
                        } else {
                            startCountdown()
                        }
                    }
            }
            
            .onAppear {
                startCountdown()
            }
            .navigationDestination(isPresented: $countdownFinished) {
                SessionPagingView()
            }
            
            
   
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        
    }

    func startCountdown() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            countdownFinished = true
        }
    }
    
    
        
}


#Preview {
    CountDownView()
}
