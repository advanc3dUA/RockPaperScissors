//
//  RPS+MLDetect.swift
//  RockPaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import UIKit
import CreateML
import Vision

extension RPSViewController {
    
    func detect(image: CIImage) {
        let mlModelConfiguration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: HandSigns(configuration: mlModelConfiguration).model) else {
            fatalError("Error while creating model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Couldn't get result from request with error: \(String(describing: error))")
            }
            
            if let bestResult = results.first?.identifier {
                var modifiedResult = ""
                
                switch bestResult {
                case "FistHand": modifiedResult = K.rock
                case "FiveHand": modifiedResult = K.paper
                case "VictoryHand": modifiedResult = K.scissors
                default: modifiedResult = K.none
                }
                // let modifiedResult = "rock"
                print("playerResult: \(modifiedResult)")
                
                if self.isValidResult(modifiedResult) {
                    self.game.makeMove(with: modifiedResult) { aiChoice in
                        print("aiResult= \(aiChoice)")
                        self.aiPickerPosition = self.getNewPositionForAIPicker(aiChoice: aiChoice)
                    }
                    self.playButton.setTitle("Play again!", for: .normal)
                    
                } else {
                    self.matchResultLabel.isHidden = false
                    self.matchResultLabel.text = "Can't recognize, try again"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func isValidResult(_ result: String) -> Bool {
        if result == "none" { return false }
        return true
    }
}
