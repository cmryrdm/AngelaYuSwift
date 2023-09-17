//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchTextField.delegate = self
    weatherManager.delegate = self
    locationManager.delegate = self
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Search"
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let city = searchTextField.text {
      weatherManager.fetchWeather(cityName: city)
    }
    searchTextField.text = ""
  }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
      self.temperatureLabel.text = weather.temperatureString
      self.cityLabel.text = weather.cityName
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
    }
  }
  
  func didFailWithError(_ error: Error) {
    print(error)
  }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
  
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    // Ensure we have at least one location
    guard let location = locations.last else { return }
    
    locationManager.stopUpdatingLocation()

    let lat = location.coordinate.latitude
    let lon = location.coordinate.longitude
    
    self.weatherManager.fetchWeather(lat: lat, lon: lon)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
  
  @IBAction func currentLocationPressed(_ sender: UIButton) {
    locationManager.requestLocation()
  }
  
}

