//
//  GameRoll.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

class GameRoll {
    private var nbKnockedPins: Int

    init(knockedPins: Int) {
        nbKnockedPins = knockedPins
    }

    func isStrike() -> Bool {
        return nbKnockedPins == 10
    }

    func getKnockedPins() -> Int {
        return nbKnockedPins
    }
}
