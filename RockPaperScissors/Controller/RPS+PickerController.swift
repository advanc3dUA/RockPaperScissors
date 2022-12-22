//
//  RPS+PickerController.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import UIKit

extension RPSViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupPickerController() {
        
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let ciImage = CIImage(image: selectedImage) else {
                fatalError("Couldn't convert selectedImage to ciImage")
            }
            detect(image: ciImage)
            
            pickerController.dismiss(animated: true)
        }
    }
}
