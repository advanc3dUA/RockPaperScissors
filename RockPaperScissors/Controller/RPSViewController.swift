//
//  RPSViewController.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import UIKit

class RPSViewController: UIViewController {
    
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var aiPickerView: UIPickerView!
    @IBOutlet weak var playerPickerView: UIPickerView!
    
    var game = Game()
    var pickerController = UIImagePickerController()
    var timer = Timer()
    var aiPickerPosition: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aiPickerView.dataSource = self
        aiPickerView.delegate = self
        playerPickerView.delegate = self
        playerPickerView.dataSource = self
        setupPickerController()
    }
    
    @IBAction func playPressed(_ sender: UIButton) {

        if sender.titleLabel?.text == "Play" {
            present(pickerController, animated: true)
        } else {
            
            game.playersChoice = K.playerImageList[playerPickerView.selectedRow(inComponent: 0)]

            let newAIPickerPosition = Int.random(in: 0..<K.aiImageList.count)
            let aiChoice = K.aiImageList[newAIPickerPosition]
            game.aIChoice = aiChoice
            
            self.aiPickerPosition = newAIPickerPosition
            setNewRowForAIPickerView()
            playerPickerView.isUserInteractionEnabled = false
            playButton.isHidden = true
        }
        
    }
}


