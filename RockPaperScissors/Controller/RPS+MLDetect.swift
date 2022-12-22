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
                let modifiedResult = self.setModifiedResult(with: bestResult)
                 
                self.playerPickerView.isHidden = false
                self.playerPickerView.isUserInteractionEnabled = true
                
                switch modifiedResult {
                case K.rock: self.playerPickerView.selectRow(0, inComponent: 0, animated: true)
                case K.paper: self.playerPickerView.selectRow(1, inComponent: 0, animated: true)
                default: self.playerPickerView.selectRow(2, inComponent: 0, animated: true)
                }
                
                self.playButton.setTitle("Confirm", for: .normal)
                self.playButton.tintColor = .red
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func setModifiedResult(with result: String) -> String {
        
        switch result {
        case "FistHand": return K.rock
        case "FiveHand": return K.paper
        case "VictoryHand": return K.scissors
        default:
            let random = Int.random(in: 0...2)
            return K.ImageList.player[random]
        }
    }
}
