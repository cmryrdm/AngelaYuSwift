//
//  BmiModel.swift
//  BMI Calculator
//
//  Created by CEMRE YARDIM on 12.09.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class BmiBrain {
    private var bmi: BmiModel?
    
    func calculateBmi(weight: Float, height: Float) {
        let bmiValue =  weight / (height * height)
        
        if bmiValue < 18.5 {
            bmi = BmiModel(value: bmiValue, advice: "You need to gain weight!", color: .systemOrange)
        } else if bmiValue < 25 {
            bmi = BmiModel(value: bmiValue, advice: "You are fit!", color: .systemGreen)
        } else {
            bmi = BmiModel(value: bmiValue, advice: "You need to lose weight!", color: .systemRed)
        }
    }
    
    func getValue() -> Float {
        return bmi?.value ?? 0.0
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? ""
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .systemBackground
    }
}

