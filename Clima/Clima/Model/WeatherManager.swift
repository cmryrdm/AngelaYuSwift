//
//  WeatherManager.swift
//  Clima
//
//  Created by CEMRE YARDIM on 16.09.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(_ error: Error)
}


struct WeatherManager {
  // App id for openweathermap is required!
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=<>&units=metric"
  
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(with: urlString)
  }
  
  func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
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
          //let dataString = String(data: safeData, encoding: .utf8)
          if let weather = self.parseJSON(safeData) {
            self.delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      // Start the task
      task.resume()
    }
  }
  
  func parseJSON(_ weatherdata: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(WeatherData.self, from: weatherdata)
      let name = decodedData.name
      let temp = decodedData.main.temp
      let id = decodedData.weather[0].id
      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather
    } catch {
      self.delegate?.didFailWithError(error)
      return nil
    }
    
  }
}

