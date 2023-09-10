//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by CEMRE YARDIM on 10.09.2023.
//  
//

import Foundation

struct QuizBrain {
    
    let quizzes = [
        Quiz(q: "A slug's blood is green.", a: "True"),
        Quiz(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Quiz(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Quiz(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Quiz(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Quiz(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Quiz(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Quiz(q: "Google was originally called 'Backrub'.", a: "True"),
        Quiz(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Quiz(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Quiz(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Quiz(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    private var quizNum = 0
    private var quizScore = 0
    
    mutating func check(_ answer: String) -> Bool {
        var temp = false
        if quizNum < quizzes.count && answer == quizzes[quizNum].answer {
            quizScore += 1
            temp = true
        }
        quizNum += 1
        return temp
    }
    
    func getProgress() -> Float {
        return Float(quizNum + 1) / Float(quizzes.count)
    }
    
    mutating func getQuestion() -> String {
        if quizNum == quizzes.count {
            quizNum = 0
            quizScore = 0
        }
        return quizzes[quizNum].question
    }
    
    func getScore() -> Int {
        return quizScore
    }
    
    
}
