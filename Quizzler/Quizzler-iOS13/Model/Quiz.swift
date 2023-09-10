//
//  Quiz.swift
//  Quizzler-iOS13
//
//  Created by CEMRE YARDIM on 9.09.2023.
//  
//

import Foundation

struct Quiz {
    let question: String
    let answer: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.question = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }
}

