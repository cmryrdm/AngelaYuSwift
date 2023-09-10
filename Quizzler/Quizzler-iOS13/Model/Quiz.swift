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
    let answer: String
    
    init(q: String, a: String) {
        self.question = q
        self.answer = a
    }
}

