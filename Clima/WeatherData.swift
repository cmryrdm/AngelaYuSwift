//
//  WeatherData.swift
//  Clima
//
//  Created by CEMRE YARDIM on 16.09.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

// typealias Codable = Decodable protocol + Encodable protocol
struct WeatherData: Codable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
}

struct Weather: Codable {
  let id: Int
}
