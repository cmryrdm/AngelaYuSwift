//
//  ContentView.swift
//  AngelaCard
//
//  Created by CEMRE YARDIM on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color(.systemTeal).ignoresSafeArea(.all)
      
      VStack {
        Image("AngelaYu")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200, height: 200)
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.white, lineWidth: 5))
        
        Text("Angela Yu")
          .font(Font.custom("Pacifico-Regular", size: 40))
          .bold()
          .foregroundColor(.white)
        
        Text("iOS Developer")
          .foregroundColor(.white)
          .font(.system(size: 25))
        
        Divider()
        
        RoundedView(imageName: "phone", labelText: "+44 123 456 789")
        
        RoundedView(imageName: "envelope", labelText: "angela@yu.com")
      }.padding(.all)
    }
  }
}

#Preview {
  ContentView()
}
