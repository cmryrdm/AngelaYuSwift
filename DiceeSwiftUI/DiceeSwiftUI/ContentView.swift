//
//  ContentView.swift
//  DiceeSwiftUI
//
//  Created by CEMRE YARDIM on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
  @State var leftDice = 1
  @State var rightDice = 2
  
  func rollButton() {
    leftDice = Int.random(in: 1...6)
    rightDice = Int.random(in: 1...6)
  }
  
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .ignoresSafeArea(.all)
      
      VStack {
        Image("diceeLogo")
        
        Spacer()
        
        HStack {
          DiceView(n: leftDice)
          DiceView(n: rightDice)
        }.padding(.horizontal)
        
        Spacer()
        
        ZStack {
          RoundedRectangle(cornerRadius: 12)
            .frame(width: 150, height: 75)
            .foregroundColor(Color("diceColor", bundle: nil))
          
          Button("Roll") {
            rollButton()
          }.font(.system(size: 50))
            .fontWeight(.heavy)
            .foregroundColor(.white)
        }
      }
    }
  }
}

struct DiceView: View {
  let n: Int
  
  var body: some View {
    Image("dice\(n)")
      .resizable()
      .aspectRatio(1, contentMode: .fit)
      .padding()
  }
}

#Preview {
  ContentView()
}
