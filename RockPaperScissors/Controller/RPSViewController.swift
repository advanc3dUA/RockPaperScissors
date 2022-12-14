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
    @IBOutlet weak var playerResultLabel: UILabel!
    @IBOutlet weak var aiResultLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var aiImageView: UIImageView!
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerController()

        
    }
    
    
    @IBAction func playPressed(_ sender: UIButton) {
        present(pickerController, animated: true)
    }
}
