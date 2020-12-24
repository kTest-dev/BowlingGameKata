//
//  RollState.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 12/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

enum RollState {
    
    case strike
    case spare
    case hopefull(needed:Int)
    case miss
    case nextFrame
    
    func getFeedBackMessage() -> String{
        switch self {
        case .strike:
            return "strike_feedback_message".localize()
        case .spare:
            return "spare_feedback_message".localize()
        case .hopefull(let needed):
            return String(format: "next_roll_feedback_message".localize(), needed)
        case .miss:
            return "zero_feedback_message".localize()
        case .nextFrame:
            return "next_frame_feedback_message".localize()
        }
    }
    func getFeedBackAnimationName() -> String{
        switch self {
        case .strike:
            return "confetti"
        case .spare:
            return "spare"
        case .hopefull(_),.nextFrame:
            return  "next"
        case .miss:
            return "sad"
        }
    }
}
