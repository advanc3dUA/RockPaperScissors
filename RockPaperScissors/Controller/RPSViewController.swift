//
//  RPSViewController.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import UIKit

class RPSViewController: UIViewController {
    
    var game = Game()
    var pickerController = UIImagePickerController()
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerController()

        
    }
    
    
    @IBAction func makeTurnPressed(_ sender: UIButton) {
        present(pickerController, animated: true)
    }
}
