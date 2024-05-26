//
//  GameHostingController.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 23/05/24.
//

import Foundation
import WatchKit
import SwiftUI

class GameHostingController: WKHostingController<GameView> {
    override var body: GameView {
        return GameView() 
    }
}
