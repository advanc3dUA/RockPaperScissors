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
    var timer = Timer()
    @IBOutlet weak var playerResultLabel: UILabel!
    @IBOutlet weak var aiResultLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var aiImageView: UIImageView!
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var aiPickerView: UIPickerView!
    var aiPickerPosition: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aiPickerView.dataSource = self
        aiPickerView.delegate = self
        setupPickerController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateScore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNewRowForAIPickerView()
    }
    
    private func setNewRowForAIPickerView() {
        timer = Timer.scheduledTimer(timeInterval: K.Timer.period, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        guard let newPosition = aiPickerPosition else {
            timer.invalidate()
            return
        }
        var position = aiPickerView.selectedRow(inComponent: 0)
        
        if newPosition < position {
            position -= 1
            aiPickerView.selectRow(position, inComponent: 0, animated: true)
        } else if newPosition > position {
            position += 1
            aiPickerView.selectRow(position, inComponent: 0, animated: true)
        } else if newPosition == position {
            timer.invalidate()
        }
    }
    
    
    @IBAction func playPressed(_ sender: UIButton) {
        present(pickerController, animated: true)
    }
    
    func updateScore() {
        scoreLabel.text = game.getCurrentScore()
    }
    
    func getNewAIPickerPosition(aiChoice: String) -> Int {
        var randomNum = 33
        
        while aiChoice != K.imageList[randomNum] {
            randomNum = Int.random(in: 0..<K.imageList.count)
        }
        return randomNum
    }
}

extension RPSViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.imageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(225.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(225.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let result = UIImageView(frame: CGRect(x: 0, y: 0, width: 225, height: 225))
        result.image = UIImage(named: K.imageList[row])
        return result
    }
    
    
}
