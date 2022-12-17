//
//  Constants.swift
//  RockPaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import Foundation

struct K {
    static let rock = "rock"
    static let scissors = "scissors"
    static let paper = "paper"
    
    struct ImageList {
        static var player: [String] = [K.rock, K.paper, K.scissors]
        
        static var ai: [String] = {
            let images = [K.rock, K.paper, K.scissors]
            var array = [String]()
            for index in 0...65 {
                array.append(images[index % images.count])
            }
            return array
        }()
    }
    
    struct Result {
        static let win = "✅ You won!"
        static let lose = "❌ You lost!"
        static let draw = "🤝 Draw this time"
    }
    
    struct Timer {
        static let period = 0.18
    }
}

