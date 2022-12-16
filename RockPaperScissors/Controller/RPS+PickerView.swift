//
//  RPS+PickerView.swift
//  RockPaperScissors
//
//  Created by Yuriy Gudimov on 15.12.2022.
//

import UIKit

extension RPSViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    //MARK: Datasource & Delegate
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
    
    //MARK: - Getting new position of PickerView methods
    private func updateScore() {
        scoreLabel.isHidden = false
        scoreLabel.text = game.getCurrentScore()
        matchResultLabel.text = game.getPlayerResult()
    }
    
    func getNewPositionForAIPicker(aiChoice: String) -> Int {
        var randomNum = K.imageList.count / 2
        
        while aiChoice != K.imageList[randomNum] {
            randomNum = Int.random(in: 0..<K.imageList.count)
        }
        return randomNum
    }
    
    func setNewRowForAIPickerView() {
        timer = Timer.scheduledTimer(timeInterval: K.Timer.period, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        guard let newPosition = aiPickerPosition else {
            timer.invalidate()
            return
        }
        aiPickerView.isHidden = false
        var position = aiPickerView.selectedRow(inComponent: 0)
        
        matchResultLabel.isHidden = false
        matchResultLabel.text = "AI is making decision..."
        
        if newPosition < position {
            position -= 1
            aiPickerView.selectRow(position, inComponent: 0, animated: true)
        } else if newPosition > position {
            position += 1
            aiPickerView.selectRow(position, inComponent: 0, animated: true)
        } else if newPosition == position {
            timer.invalidate()
            updateScore()
        }
    }
}
