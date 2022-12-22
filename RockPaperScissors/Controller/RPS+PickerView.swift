//
//  RPS+PickerView.swift
//  RockPaperScissors
//
//  Created by Yuriy Gudimov on 15.12.2022.
//

import UIKit

extension RPSViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    
    //MARK: Datasource & Delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return K.ImageList.ai.count
        } else {
            return K.ImageList.player.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return CGFloat(225.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CGFloat(225.0)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let result = UIImageView(frame: CGRect(x: 0, y: 0, width: 225, height: 225))
        if pickerView.tag == 1 {
            result.image = UIImage(named: K.ImageList.ai[row])
        } else {
            result.image = UIImage(named: K.ImageList.player[row])
        }
        return result
    }
    
    //MARK: - Animation of AI turn
    func setNewRowForAIPickerView(with newPosition: Int) {
        
        timer = Timer.scheduledTimer(timeInterval: K.Timer.period,
                                     target: self,
                                     selector: #selector(timerAction(sender:)),
                                     userInfo: newPosition,
                                     repeats: true)
    }
    
    @objc private func timerAction(sender: Timer) {

        guard let newPosition = sender.userInfo as? Int else {
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
            
            playButton.isHidden = false
            playButton.setTitle("Play", for: .normal)
            playButton.tintColor = .systemBlue
        }
    }
    
    //MARK: - Update UI after AI finishes it's turn
    private func updateScore() {
        
        scoreLabel.isHidden = false
        scoreLabel.text = game.getCurrentScore()
        matchResultLabel.text = game.getPlayerResult()
    }
}
