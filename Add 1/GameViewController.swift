//
//  ViewController.swift
//  Add 1
//
//  Created by Bharat Mukheja on 5/26/21.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var inputfield:UITextField?
    
    var timer:Timer?
    var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
    }
    var score = 0
    
    @IBAction func inputFieldDidChange()
    {
        guard let numberText = numberLabel?.text, let inputText = inputfield?.text else {
            return
        }
        guard inputText.count == 4 else {
            return
        }
        var isCorrect = true
        for n in 0..<4
        {
            var input = inputText.integer(at: n)
            var number = numberText.integer(at: n)
            
            if input != (number+1)%10 {
                isCorrect = false
                break
            }
        }
        if isCorrect {
            score += 1
        }
        else {
            score -= 1
        }
        
        updateNumberLabel()
        updateScoreLabel()
        inputfield?.text = ""
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds==0{
                    self.finishGame()
                }
                else if self.seconds <= 60 {
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
    
    func updateTimeLabel(){
        let min = (seconds / 60) % 60
        let sec = seconds % 60
        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    func updateScoreLabel(){
        scoreLabel?.text = String(score)
    }
    func updateNumberLabel(){
        numberLabel?.text = String.randomNumber(length: 4)
    }
    
    func finishGame(){
        timer?.invalidate()
        timer = nil
        
        let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        score = 0
        seconds = 60
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
    }
    
}

