//
//  ControlsView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 21/05/24.
//

import SwiftUI

struct ControlsView: View {
    var body: some View {
        
        //Layout Exit button
        VStack {
            Button {
            } label: {
                Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                Text("End")
        }
          
        
    }
}

#Preview {
    ControlsView()
}
