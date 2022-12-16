//
//  RPSViewController.swift
//  StonePaperScissors
//
//  Created by Yuriy Gudimov on 14.12.2022.
//

import UIKit

class RPSViewController: UIViewController {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var aiPickerView: UIPickerView!
    
    var game = Game()
    var pickerController = UIImagePickerController()
    var timer = Timer()
    var aiPickerPosition: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aiPickerView.dataSource = self
        aiPickerView.delegate = self
        setupPickerController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNewRowForAIPickerView()
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        present(pickerController, animated: true)
    }
}


