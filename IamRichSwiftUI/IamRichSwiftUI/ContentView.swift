//
//  ContentView.swift
//  IamRichSwiftUI
//
//  Created by CEMRE YARDIM on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color(.systemTeal)
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("I am Rich")
          .font(.system(size: 40))
          .fontWeight(.bold)
          .foregroundColor(Color.white)
        
        Image("diamond")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200,height: 200, alignment: .center)
        
      }
      
    }
  }
}

#Preview {
  ContentView()//.previewDevice(PreviewDevice(rawValue: "iPhone 11"))
}
