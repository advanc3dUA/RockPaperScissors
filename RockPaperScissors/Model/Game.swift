//
//  Game.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import Foundation

struct Game {
    var playersChoice: String?
    var aIChoice: String? {
        didSet {
            let result = checkPlayerResult()
            playerResult = result
            updateScoreAndPlayer(with: result)
        }
    }
    private var playerResult: String?
    private var score: (ai: Int, player: Int) = (0, 0)
        
    private mutating func updateScoreAndPlayer(with result: String) {
        
        switch result {
        case K.Result.win: score.player += 1
        case K.Result.lose: score.ai += 1
        default: return
        }
    }
    
    func getCurrentScore() -> String {
        return "Score: \(String(score.ai)):\(String(score.player))"
    }
    
    func getPlayerResult() -> String {
        return "\(playerResult!)"
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
            
        default: fatalError("Couldn't detect winner of last round")
        }
        
        return result
    }
}
