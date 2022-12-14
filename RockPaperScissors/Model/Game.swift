//
//  Game.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import Foundation

struct Game {
    private var latestTurn: String? {
        didSet {
            print("old vaule was: \(oldValue)")
            print("new value is: \(latestTurn)")
        }
    }
    
    mutating func informGame(with turn: String) {
        latestTurn = turn
    }
}
