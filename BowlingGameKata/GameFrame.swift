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
    private let lastFrameIndex = 9
    let id:String = UUID().uuidString
    
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
    
    private func getFirstRoll() -> GameRoll?{
        return rolls.first
    }
    
    func getFrameBonus(allFrames:[GameFrame]) -> Int {
            if hasStrike() {
                return strikeBonus(allFrames: allFrames)
            }
            if hasSpare() {
                return spareBonus(allFrames: allFrames)
            }
          return 0
    }
    
    private func strikeBonus(allFrames:[GameFrame]) -> Int {
        if let indexOf = allFrames.firstIndex(where: {$0.id == id}), indexOf < lastFrameIndex{
            let nextFrame  =  allFrames[indexOf+1]
            if nextFrame.hasStrike() {
                return nextFrame.getFrameScore() + allFrames[indexOf+2].getFrameScore()
            }
            return  nextFrame.getFrameScore()
        }
        return 0
    }
    
    private func spareBonus(allFrames:[GameFrame]) -> Int {
        if let indexOf = allFrames.firstIndex(where: {$0.id == id}), indexOf < lastFrameIndex {
            let nextFrame  =  allFrames[indexOf+1]
            if let roll = nextFrame.getFirstRoll() {
                return roll.getKnockedPins()
            }
        }
        return 0
    }
    
    func getNeededScore() -> Int {
        if hasStrike() {
            return 0
        }
        if !isCompleted() {
            if let firstRoll = getFirstRoll() {
                return 10 - firstRoll.getKnockedPins()
            }
        }
        return 10
    }
}
enum GameFrameErrors: Error {
    case FrameCompleted
}
