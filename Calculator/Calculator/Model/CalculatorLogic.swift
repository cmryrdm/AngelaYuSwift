//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by CEMRE YARDIM on 22.10.2023.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
  private var number: Double?
  
  private var intermediateCalculation: (n1: Double, calcMethod: String)?
  
  mutating func setNumber(_ number: Double) {
    self.number = number
  }
  
  mutating func calculate(symbol: String) -> Double? {
    if let temp = number {
      switch symbol {
      case "+/-":
        return temp * -1
      case "AC":
        return 0
      case "%":
        return temp * 0.01
      case "=":
        return performTwoNumCalculation(n2: temp)
      default:
        intermediateCalculation = (n1: temp, calcMethod: symbol)
      }
    }
    return nil
  }
  
  private func performTwoNumCalculation(n2: Double) -> Double? {
    if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
      switch operation {
      case "+":
        return n1 + n2
      case "-":
        return n1 - n2
      case "÷":
        return n1 / n2
      case "×":
        return n1 * n2
      default:
        fatalError("operation does not exist")
      }
    }
    return nil
  }
  
}
