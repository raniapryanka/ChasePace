//
//  GameView.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 23/05/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        
        let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
        scene.scaleMode = .aspectFill
        return scene
    }

    
    var body: some View {
        //SwiftUI view that renders a SpriteKit scene
        SpriteView(scene: scene)
            .frame(width: WKInterfaceDevice.current().screenBounds.size.width,
                   height: WKInterfaceDevice.current().screenBounds.size.height)
            .edgesIgnoringSafeArea(.all) //scene uses the entire screen area
    }
    
    
}
