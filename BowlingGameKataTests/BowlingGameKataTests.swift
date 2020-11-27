//
//  BowlingGameKataTests.swift
//  BowlingGameKataTests
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import XCTest
@testable import BowlingGameKata

class BowlingGameKataTests: XCTestCase {

    func testAllRollsAreStrikesScore() {
        let rolls = [10,10,10,10,10,10,10,10,10,10,10,10]
        
        let game = BowlingGame()
        for roll in rolls {
            game.play(pins: roll)
        }
        XCTAssertEqual(game.getScore(), 300, "When all rolls are Strikes we expect to have a score of 300")
    }
    func testAllFramesAreSparesScore() {
        let rolls = [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]
        
        let game = BowlingGame()
        for roll in rolls {
            game.play(pins: roll)
        }
        XCTAssertEqual(game.getScore(), 150, "When each roll knocks 5 pins we expect to have a score of 150")
    }
}
