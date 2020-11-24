//
//  GameRollTests.swift
//  BowlingGameKataTests
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import XCTest

class GameRollTests: XCTestCase {

    func testGameRollIsStrike(){
        XCTAssertTrue(GameRoll(knockedPins:10).isStrike(), "When all pins are knocked in a game roll. the roll should be a strike")
    }
    func testGameRollIsNotStrike(){
          XCTAssertFalse(GameRoll(knockedPins:1).isStrike(), "When few pins are knocked in a game roll. the roll should not be a strike")
      }
}
