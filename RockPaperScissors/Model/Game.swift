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
            aIChoice = generateNewTurn()
        }
    }
    private var aIChoice: String?
    
    mutating func makeMove(with choice: String, completion: (String, String) -> ()) {
        playersChoice = choice
        
        if let safeAIChoice = aIChoice {
            completion(safeAIChoice, checkPlayerResult())
        } else {
            fatalError("aiChoice had been nil when completion was executed")
        }
    }
    
    private mutating func generateNewTurn() -> String {
        var choice = ""
        
        let random = Int.random(in: 0...2)
        switch random {
        case 0: choice = K.rock
        case 1: choice = K.scissors
        case 2: choice = K.paper
        default: choice = K.none
        }
        return choice
    }
    
    private func checkPlayerResult() -> String {
        var result = ""
        switch (aIChoice, playersChoice) {
            
        case (K.rock, K.rock): result = K.Result.draw
        case (K.paper, K.paper): result = K.Result.draw
        case (K.scissors, K.scissors): result = K.Result.draw
        
        case (K.rock, K.paper): result = K.Result.win
        case (K.rock, K.scissors): result = K.Result.lose
            
        case (K.paper, K.rock): result = K.Result.lose
        case (K.paper, K.scissors): result = K.Result.win
            
        case (K.scissors, K.rock): result = K.Result.win
        case (K.scissors, K.paper): result = K.Result.lose
            
        //default: fatalError("Couldn't detect winner of last round")
        default: result = "someone has won"
        }
        
        return result
    }
}
