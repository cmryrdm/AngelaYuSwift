//
//  RoundedView.swift
//  AngelaCard
//
//  Created by CEMRE YARDIM on 28.09.2023.
//

import SwiftUI

struct RoundedView: View {
  let imageName: String
  let labelText: String
  
  init(imageName: String, labelText: String) {
    self.imageName = imageName
    self.labelText = labelText
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(.white)
        .frame(height: 50)
      
      HStack {
        Image(systemName: self.imageName)
        
        Text(self.labelText)
        
      }.foregroundColor(.teal)
        .font(.system(size: 25))
    }
  }
}

struct RoundedView_Previews: PreviewProvider {
    static var previews: some View {
      RoundedView(imageName: "apple.logo", labelText: "think different.").previewLayout(.sizeThatFits)
    }
}


//#Preview {
//  RoundedView(imageName: "apple.logo", labelText: "think different.").previewLayout(.sizeThatFits)
//}
