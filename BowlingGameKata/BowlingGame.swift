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
    
    func play(pins:Int) {
        
        if let currentFrame = frames.last, !currentFrame.isCompleted() {
            do {
                try currentFrame.addRoll(roll: GameRoll(knockedPins: pins))
            } catch {
                fatalError("A frame should have at most two rolls")
            }
        }else{
            let frame = GameFrame()
            do {
                try frame.addRoll(roll: GameRoll(knockedPins: pins))
            } catch {
                fatalError("A frame should have at most two rolls")
            }
            frames.append(frame)
        }
    }
    
    
    func allFrames() -> [GameFrame] {
        return frames
    }
}
