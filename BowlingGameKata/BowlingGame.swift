//
//  BowlingGame.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

class BowlingGame {
    private var frames: [GameFrame] = []
    
    func play(pins:Int) {
        
        if let currentFrame = frames.last {
            
        }else{
            let frame = GameFrame()
            frames.append(frame)
        }
    }
    
    
    func allFrames() -> [GameFrame] {
        return frames
    }
}
