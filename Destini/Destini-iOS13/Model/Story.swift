//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story {
    private let title: String
    private let choice1: String
    private let choice2: String
    private let choice1Destination: Int
    private let choice2Destination: Int
    
    
    public init(title: String, choice1: String, choice1Destination: Int, choice2: String,  choice2Destination: Int) {
           self.title = title
           self.choice1 = choice1
           self.choice2 = choice2
           self.choice1Destination = choice1Destination
           self.choice2Destination = choice2Destination
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getChoice1() -> String {
        return choice1
    }
    
    func getChoice2() -> String {
        return choice2
    }
    
    func getChoice1Destination() -> Int {
        return choice1Destination
    }
    
    func getChoice2Destination() -> Int {
        return choice2Destination
    }

}
