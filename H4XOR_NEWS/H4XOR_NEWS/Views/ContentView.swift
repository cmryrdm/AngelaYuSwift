//
//  ContentView.swift
//  H4XOR_NEWS
//
//  Created by CEMRE YARDIM on 1.10.2023.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var networkManager = NetworkManager()
  
  var body: some View {
    NavigationView {
      List(networkManager.posts) { post in
        NavigationLink(destination: DetailView(url: post.url)) {
          HStack {
            Text(String(post.points))
            Text(post.title)
          }
        }
      }
      .navigationTitle("H4XOR NEWS")
    }
    .onAppear(perform: {
      networkManager.fetchData()
    })
  }
}



#Preview {
  ContentView()
}
