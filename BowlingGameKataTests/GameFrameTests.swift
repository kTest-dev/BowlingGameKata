//
//  GameFrameTests.swift
//  BowlingGameKataTests
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import XCTest
@testable import BowlingGameKata
class GameFrameTests: XCTestCase {

    func testCreateEmptyGameFrame() {
        let frame = GameFrame()
        XCTAssertTrue(frame.numberOfPlayedRolls() == 0, "When creating an empty frame the number of played rolls should be 0")
    }
    func testAddGameRoll(){
        let frame = GameFrame()
        let gameRoll = GameRoll(knockedPins:2)
            try? frame.addRoll(roll:gameRoll)
        XCTAssertTrue(frame.numberOfPlayedRolls() == 1, "When add a one roll the number of played rolls should be 1")
    }
    
    func testFrameIsCompleted() {
         let frame = GameFrame()
            try? frame.addRoll(roll:GameRoll(knockedPins:2))
            try? frame.addRoll(roll:GameRoll(knockedPins:2))
        XCTAssertTrue(frame.isCompleted(), "When two roll are played in the same frame. the frame should be completed")
    }
    func testFrameIsCompletedWhenHasAStrike(){
        let frame = GameFrame()
          try? frame.addRoll(roll:GameRoll(knockedPins:10))
         XCTAssertTrue(frame.isCompleted(), "When a frame has a strike. the frame should be completed")
    }
    func testGameFrameShouldAcceptOnlyTwoRolls(){
        let frame = GameFrame()
        for _ in 1...3 {
            try? frame.addRoll(roll:GameRoll(knockedPins:2))
        }
        XCTAssertThrowsError(try frame.addRoll(roll:GameRoll(knockedPins:2)),"A game frame should only have at most 2 rolls") {
            error in
            XCTAssertEqual(error as? GameFrameErrors, GameFrameErrors.FrameCompleted)
        }
    }
    func testGameFrameHasAStrike(){
        let frame = GameFrame()
        try? frame.addRoll(roll:GameRoll(knockedPins:10))
        XCTAssertTrue(frame.hasStrike(), "When the first roll knowcked all pins. the frame should has a strike")
    }
    func testGameFrameDosentHasAStrike(){
          let frame = GameFrame()
          try? frame.addRoll(roll:GameRoll(knockedPins:2))
          XCTAssertFalse(frame.hasStrike(), "When the first roll didn't knowck all pins. the frame shouldn't have a strike")
      }
}
