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
    static let none = "none"
    
    static var imageList: [String] = {
        let images = [K.rock, K.paper, K.scissors]
        var array = [String]()
        for index in 0...98 {
            array.append(images[index % images.count])
        }
        return array
    }()
    
    struct Result {
        static let win = "You won!"
        static let lose = "You lost!"
        static let draw = "Draw this time"
    }
    
    struct Timer {
        static let period = 0.2
    }
}
