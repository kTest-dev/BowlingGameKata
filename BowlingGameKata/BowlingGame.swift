//
//  BowlingGame.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

class BowlingGame {
    
    private var frames: [GameFrame] = [GameFrame()]
    
    func play(pins:Int) {
        
        do {
            let currentRoll = GameRoll(knockedPins: pins)
            if let frame = frames.last, !frame.isCompleted() {
               try frame.addRoll(roll: currentRoll)
            }else{
               let newFrame = GameFrame()
               try newFrame.addRoll(roll: currentRoll)
                   frames.append(newFrame)
            }
        }catch {
            fatalError("A frame should have at most two rolls")
        }
    }
    
    func allFrames() -> [GameFrame] {
        return frames
    }
    
   func getScore() -> Int {
        var score = 0
        for (_,frame) in  frames.enumerated(){
            score += frame.getFrameScore() + frame.getFrameBonus(allFrames: frames)
        }
        return score
    }
}


