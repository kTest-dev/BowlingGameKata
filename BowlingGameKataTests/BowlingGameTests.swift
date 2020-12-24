//
//  BowlingGameTests.swift
//  BowlingGameKataTests
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import XCTest
@testable import BowlingGameKata
class BowlingGameTests: XCTestCase {

    func testNbFramesWhenOneRollPlayed() {
        let game =  BowlingGame()
            game.play(pins: 1)
        XCTAssertTrue(game.allFrames().count == 1, "the game should have only one frame")
    }
    func testNbFramesWhenTwoNormalRollsPlayed() {
        let game =  BowlingGame()
            game.play(pins: 1)
            game.play(pins: 4)
        XCTAssertTrue(game.allFrames().count == 1, "the game should have only one frame")
    }
    func testNbFramesWhen20NormalRollsPlayed() {
        let game =  BowlingGame()
        for _ in 1...20 {
            game.play(pins: 2)
        }
        XCTAssertTrue(game.allFrames().count == 10, "the game should have only 10 frame")
    }

    func testNbFramesWhenAllRollsAreStrikes() {
        let game =  BowlingGame()
        for _ in 1...10 {
          game.play(pins: 10)
        }
        XCTAssertTrue(game.allFrames().count == 10, "the game should have only 10 frame")
    }

    func testGetScoreWhenNoPinKnockedInAllRolls() {
        let game = BowlingGame()
        for _ in 1...20 {
            game.play(pins: 0)
        }
        XCTAssertEqual(game.getScore(), 0, "When No pin is knocked the score should be 0")
    }

    func testGetScoreWhen20NormalRollsPlayed() {
        let game = BowlingGame()
        for _ in 1...20 {
            game.play(pins: 2)
        }
        XCTAssertEqual(game.getScore(), 40, "When for each roll only 2 pins are knocked the score should be 40")
    }
    func testGameFinishedWhen20NormalRollsPlayed() {
        let game = BowlingGame()
        for _ in 1...20 {
            game.play(pins: 2)
        }
        XCTAssertTrue(game.isFinished(), "When normal 20 rolls are played the game should be finished")
    }
    func testGameFinishedWhenLastRollsIsAStrike() {
        let game = BowlingGame()
        for _ in 1...18 {
            game.play(pins: 2)
        }
         game.play(pins: 10)
        XCTAssertTrue(!game.isFinished(), "When last roll is a strike the player should have a bonus frame")
    }
    func testGameFinishedWhenLastRollsIsAStrikeAndBonusIsStrike() {
        let game = BowlingGame()
        for _ in 1...18 {
            game.play(pins: 2)
        }
         game.play(pins: 10)
         game.play(pins: 10)
        XCTAssertTrue(game.isFinished(), "When last roll is a strike the player and the bonus frame is also a strike the game should be finished")
    }
    func testGameFinishedWhenLastRollsIsAStrikeAndBonus() {
        let game = BowlingGame()
        for _ in 1...18 {
            game.play(pins: 2)
        }
         game.play(pins: 10)
         game.play(pins: 5)
        XCTAssertTrue(game.isFinished(), "When last roll is a strike the player and the bonus frame is also a strike the game should be finished")
    }
}
