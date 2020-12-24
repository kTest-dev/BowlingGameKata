//
//  BowlingGameViewModel.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 12/23/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation
class BowlingGameViewModel {
    
    var state: Box<GameState>
    var randomValue: Box<Int>
    var frameNumber: Box<Int>
    var finalScore: Box<Int>
    var feedback: Box<RollState?>
    
    var currentGame: BowlingGame?
    
    init() {
        self.state = Box<GameState>(.newGame)
        self.randomValue = Box<Int>(0)
        self.frameNumber = Box<Int>(0)
        self.finalScore = Box<Int>(0)
        self.feedback = Box<RollState?>(nil)
    }
    
    func didClickOnPlayBtn() {
        switch state.value {
        case .newGame:
            createNewGame()
            return
        case .finished:
            calculateFinalScore()
            return
        case .inProgress:
            playNewRoll()
            return
        }
    }
    
    func didClickOnNewGame() {
        createNewGame()
    }
    
    private func generateRandom(lower: Int, heigher: Int) -> Int {
        return Int.random(in: lower...heigher)
    }
    private func createNewGame() {
        currentGame = BowlingGame()
        playNewRoll()
    }
    
    private func playNewRoll() {
        randomValue.value = generateRandom(lower: 0, heigher: 10)
        if let lastFrame = currentGame?.allFrames().last {
            if !lastFrame.isCompleted() {
                randomValue.value = generateRandom(lower: 0, heigher: lastFrame.getNeededScore())
            }
        }
        currentGame?.play(pins: randomValue.value)
        frameNumber.value = currentGame?.allFrames().count ?? 0
        updateGameState()
    }
    private func updateGameState() {
        if currentGame?.isNewGame() ?? true {
            state.value = .newGame
            return
        } else if !currentGame!.isFinished() {
            state.value = .inProgress
            setFeedBack()
        } else {
            state.value = .finished
        }
    }
    private func calculateFinalScore() {
        self.finalScore.value = currentGame?.getScore() ?? 0
    }
    private func setFeedBack() {
        guard let currentFrame = currentGame?.allFrames().last else{
            return
        }
        if  currentFrame.hasStrike() {
            self.feedback.value = .strike
            return
        }
        if  currentFrame.hasSpare() {
            self.feedback.value = .spare
            return
        }
        if !currentFrame.isCompleted() {
            let neededScore = currentFrame.getNeededScore()
            if neededScore == 10 {
                self.feedback.value = .miss
            } else {
                self.feedback.value = .hopefull(needed: neededScore)
            }
            return
        } else {
            if currentFrame.getSecondRoll()?.getKnockedPins() == 0 {
                self.feedback.value = .miss
            } else {
                self.feedback.value = .nextFrame
            }
        }
    }
    
}
