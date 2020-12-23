//
//  GameState.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 12/23/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation
import UIKit

enum GameState {
    
    case newGame
    case finished
    case inProgress
    
    func getButtonColor() -> UIColor? {
        switch self  {
        case .newGame:
            return  UIColor(named: "blueColor")
        case .finished:
            return  UIColor(named: "pinkColor")
        case .inProgress:
            return UIColor(named: "greenColor")
        }
    }
    
    func getButtonText() -> String? {
        switch self {
        case .newGame:
            return  "start_new_game_btn".localize()
        case .finished:
            return "calculate_score_btn".localize()
        case .inProgress:
           return  "roll_btn".localize()
        }
    }
    
}
