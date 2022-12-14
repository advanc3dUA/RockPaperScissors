//
//  Game.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import Foundation

struct Game {
    private var playersChoice: String? {
        didSet {
            print("playerChoice set to \(playersChoice)")
        }
    }
    private var aIChoice: String? {
        didSet {
            print("aiChoice set to \(aIChoice)")
            // compare
        }
    }
    
    mutating func newTurnWasMade(with turn: String, completion: (String) -> ()) {
        playersChoice = turn
        completion(generateNewTurn())
    }
    
    private mutating func generateNewTurn() -> String {
        var choice = ""
        
        let random = Int.random(in: 0...2)
        switch random {
        case 0: choice = K.rock
        case 1: choice = K.paper
        case 2: choice = K.paper
        default: choice = K.none
        }
        
        aIChoice = choice
        return choice
    }
    
    private func playerWin(ai aiChoice: String, player playerChoice: String) -> String {
        var result = ""
        switch (aiChoice, playerChoice) {
            
        case (K.rock, K.rock): result = K.Result.draw
        case (K.paper, K.paper): result = K.Result.draw
        case (K.scissors, K.scissors): result = K.Result.draw
        
        case (K.rock, K.paper): result = K.Result.win
        case (K.rock, K.scissors): result = K.Result.lose
            
        case (K.paper, K.rock): result = K.Result.lose
        case (K.paper, K.scissors): result = K.Result.win
            
        case (K.scissors, K.rock): result = K.Result.win
        case (K.scissors, K.paper): result = K.Result.lose
            
        default: fatalError("Couldn't detect winner of last round")
        }
        
        return result
    }
}
