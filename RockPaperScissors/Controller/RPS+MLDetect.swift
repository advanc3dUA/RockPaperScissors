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
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: mlModelConfiguration).model) else {
            fatalError("Error while creating model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Couldn't get result from request with error: \(String(describing: error))")
            }
            
            if let bestResult = results.first?.identifier {
                var modifiedResult = bestResult
   
                self.game.makeMove(with: modifiedResult) { aiChoice, playerResult in
                    self.aiResultLabel.text = aiChoice
//                    self.aiImageView.image = UIImage(named: aiChoice)
//                    self.aiPickerView.selectRow(self.getNewAIPickerPosition(aiChoice: aiChoice), inComponent: 0, animated: true)
                    self.aiPickerPosition = self.getNewAIPickerPosition(aiChoice: aiChoice)
                    
                    self.matchResultLabel.isHidden = false
                    self.matchResultLabel.text = playerResult
                }

                self.playerResultLabel.text = "You selected: \(modifiedResult)"
                self.playButton.setTitle("Play again!", for: .normal)
            }
        }
            
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
