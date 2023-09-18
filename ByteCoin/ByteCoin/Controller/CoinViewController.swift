//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
  
  @IBOutlet weak var currencyPicker: UIPickerView!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var coinImage: UIImageView!
  
  var coinManager = CoinManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    currencyPicker.dataSource = self
    currencyPicker.delegate = self
    coinManager.delegate = self
  }
}

//MARK: - UIPickerViewDataSource
extension CoinViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    coinManager.coinArray.count
  }
}

//MARK: - UIPickerViewDelegate
extension CoinViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return coinManager.coinArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedCoin = coinManager.coinArray[row]
    coinImage.image = UIImage(named: selectedCoin)
    
    coinManager.getCoinPrice(for: selectedCoin)
    
  }
}

//MARK: - CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate {
  func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
    DispatchQueue.main.async { [weak self] in
      self?.priceLabel.text = String(format: "%.2f", coin.rate)
    }
  }
  
  func didFailWithError(_ error: Error) {
    print(error)
  }
}



