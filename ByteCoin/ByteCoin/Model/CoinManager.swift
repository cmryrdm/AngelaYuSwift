//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
  func didFailWithError(_ error: Error)
}

struct CoinManager {
  
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
  let apiKey = "YOUR_API_KEY_HERE"
  
  
  let coinArray = ["BTC", "ETH","USDT","BNB","XRP"]
  
  var delegate: CoinManagerDelegate?
  
  func getCoinPrice(for coin: String) {
    let urlString = "\(baseURL)\(coin)/USD/apikey-\(apiKey)"
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    // create Url
    if let url = URL(string: urlString) {
      // Create a UrlSession
      let session = URLSession(configuration: .default)
      
      // Give the session a task
      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          self.delegate?.didFailWithError(error!)
          return
        }
        if let safeData = data {
          if let coin = self.parseJSON(safeData) {
            self.delegate?.didUpdateCoin(self, coin: coin)
          }
        }
      }
      // Start the task
      task.resume()
    }
  }
  
  func parseJSON(_ coindata: Data) -> CoinModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CoinModel.self, from: coindata)
      let rate = decodedData.rate
      let coin = CoinModel(rate: rate)
      return coin
    } catch {
      self.delegate?.didFailWithError(error)
      return nil
    }
  }
  
}
