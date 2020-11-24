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
        return rolls.count == 2
    }
}


enum GameFrameErrors: Error {
    case FrameCompleted
}
