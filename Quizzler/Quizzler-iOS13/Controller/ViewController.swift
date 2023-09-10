//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        ask()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else {return}
        if quizBrain.check(answer) {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ask), userInfo: nil, repeats: false)
    }
    
    @objc func ask() {
        answerButton.backgroundColor = UIColor.clear
        answerButton2.backgroundColor = UIColor.clear
        answerButton3.backgroundColor = UIColor.clear
        
        questionLabel.text = quizBrain.getNext().question
        answerButton.setTitle(quizBrain.getNext().answer[0], for: .normal)
        answerButton2.setTitle(quizBrain.getNext().answer[1], for: .normal)
        answerButton3.setTitle(quizBrain.getNext().answer[2], for: .normal)
        
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        progressBar.progress = quizBrain.getProgress()
    }
}


