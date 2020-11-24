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
            game.play(pins:1)
        XCTAssertTrue(game.allFrames().count == 1, "the game should have only one frame")
    }
    func testNbFramesWhenTwoNormalRollsPlayed() {
        let game =  BowlingGame()
            game.play(pins:1)
            game.play(pins:4)
        XCTAssertTrue(game.allFrames().count == 1, "the game should have only one frame")
    }
    func testNbFramesWhen20NormalRollsPlayed(){
        let game =  BowlingGame()
        for _ in 1...20 {
            game.play(pins:2)
        }
        XCTAssertTrue(game.allFrames().count == 10, "the game should have only 10 frame")
    }

}
