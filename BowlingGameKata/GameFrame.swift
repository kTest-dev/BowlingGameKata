//
//  File.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation


class GameFrame {
    private var rolls:[GameRoll] = []
    
    
    func addRoll(roll:GameRoll) throws  {
        guard !isCompleted() else {
            throw GameFrameErrors.FrameCompleted
        }
        rolls.append(roll)
    }
    func numberOfPlayedRolls() -> Int{
        return rolls.count
    }
    func isCompleted() -> Bool{
        return hasStrike() || (rolls.count == 2)
    }
    
    func hasStrike() -> Bool {
        return rolls.first?.isStrike() ?? false
    }
    func hasSpare() -> Bool{
        
        if hasStrike() {
            return false
        }
        return getFrameScore() == 10
    }
    
    func getFrameScore() -> Int {
        return rolls.reduce(0) { (result, roll) -> Int in
                 return result + roll.getKnockedPins()
            
        }
    }
}
enum GameFrameErrors: Error {
    case FrameCompleted
}
