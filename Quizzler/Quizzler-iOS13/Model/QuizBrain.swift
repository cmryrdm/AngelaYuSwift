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
        Quiz(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Quiz(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Quiz(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Quiz(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Quiz(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Quiz(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Quiz(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Quiz(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Quiz(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Quiz(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    private var quizNum = 0
    private var quizScore = 0
    
    func getProgress() -> Float {
        return Float(quizNum + 1) / Float(quizzes.count)
    }
    
    func getScore() -> Int {
        return quizScore
    }
    
    mutating func check(_ answer: String) -> Bool {
        var temp = false
        if quizNum < quizzes.count && answer == quizzes[quizNum].correctAnswer {
            quizScore += 1
            temp = true
        }
        quizNum += 1
        return temp
    }
    
    mutating func getNext() -> (question: String, answer: [String]) {
        if quizNum == quizzes.count {
            quizNum = 0
            quizScore = 0
        }
        return (quizzes[quizNum].question, quizzes[quizNum].answer)
    }
    
}
