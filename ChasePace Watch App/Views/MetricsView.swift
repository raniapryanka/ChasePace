//
//  MetricsView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

struct MetricsView: View {
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            //ngasih liat Metrics (Workout data) live monitor
            //time text field --> default text
            Text("03:15.23")
                .foregroundColor(Color.yellow)
                .fontWeight(.semibold)
            
            //active energy measurement text field --> ambil dari workout manager
            Text(
                Measurement(
                    value: 47,
                    unit: UnitEnergy.kilocalories
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout,
                        numberFormatStyle: .number.precision(.fractionLength(0))
                    )
                )
            )
            
            //heart rate text field --> ambil dari workout manager
            Text(
                153.formatted(
                    .number.precision(.fractionLength(0))
                )
                + "bpm"
                
            )
            
            //distance text view --> ambil dari workout manager
            Text(
                Measurement(
                    value: 515,
                    unit: UnitLength.meters
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .road
                    )
                )
                
            )
            
        }//end of vstack
        .font(.system(.title, design: .rounded) .monospaced() . lowercaseSmallCaps()
        )
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
        




    }
}

#Preview {
    MetricsView()
}
