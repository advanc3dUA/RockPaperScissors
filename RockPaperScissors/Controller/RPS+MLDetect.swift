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
                // edit here if it is not pure string
                
                self.game.informGame(with: modifiedResult)
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
