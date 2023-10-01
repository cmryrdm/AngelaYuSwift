//
//  DetailView.swift
//  H4XOR_NEWS
//
//  Created by CEMRE YARDIM on 1.10.2023.
//

import SwiftUI

struct DetailView: View {
  
  let url: String?
  
  var body: some View {
    WebView(urlString: url)
  }
}

#Preview {
  DetailView(url: "https://www.google.com")
}
