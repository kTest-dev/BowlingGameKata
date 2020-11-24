//
//  BowlingGame.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

class BowlingGame {
    
    private var frames: [GameFrame] = []
    private var currentFrame: GameFrame = GameFrame()
    
    func play(pins:Int) {
        
        do {
            try currentFrame.addRoll(roll: GameRoll(knockedPins: pins))
        }catch { fatalError("A frame should have at most two rolls") }
        
        if currentFrame.isCompleted() || frames.isEmpty {
            frames.append(currentFrame)
            currentFrame = GameFrame()
        }
    }
    
    
    func allFrames() -> [GameFrame] {
        return frames
    }
}
