//
//  ViewController.swift
//  WhatFlower
//
//  Created by CEMRE YARDIM on 15.01.2024.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UINavigationControllerDelegate {
  
  let imagePicker = UIImagePickerController()
  let wikipediaURl = "https://en.wikipedia.org/w/api.php"
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imagePicker.delegate = self
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .camera
    
    imageView.contentMode = .scaleAspectFill
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.minimumScaleFactor = 0.5
    label.adjustsFontSizeToFitWidth = true
    
    navigationItem.titleView?.backgroundColor = .systemGreen.withAlphaComponent(0.5)
    view.backgroundColor = .systemGreen
  }

  @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  func detect(image: CIImage) {
    guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
      fatalError("Cannot import model")
    }
    let request = VNCoreMLRequest(model: model) { request, error in
      guard let classification = request.results?.first as? VNClassificationObservation else {
        fatalError("could not classify image")
      }
      self.navigationItem.title = classification.identifier.capitalized
      self.requestInfo(flowerName: classification.identifier)
    }
    let handler = VNImageRequestHandler(ciImage: image)
    do {
      try handler.perform([request])
    } catch {
      print(error)
    }
  }
  
  func requestInfo(flowerName: String) {
    let parameters : [String:String] = [
      "format" : "json",
      "action" : "query",
      "prop" : "extracts|pageimages",
      "exintro" : "",
      "explaintext" : "",
      "titles" : flowerName,
      "indexpageids" : "",
      "redirects" : "1",
      "pithumbsize" : "500",
    ]
    
    AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { response in
      switch response.result {
      case .success(let value):
        print("got the wikipedia info.")
        print(response)
        
        let flowerJSON: JSON = JSON(value)
        let pageId = flowerJSON["query"]["pageids"][0].stringValue
        let flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
//        let flowerImageUrl = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
        
        self.label.text = flowerDescription
//        self.imageView.sd_setImage(with: URL(string: flowerImageUrl))
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
}

extension ViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      guard let convertedCIImage = CIImage(image: userPickedImage) else {
        fatalError("Cannot convert to CIImage")
      }
      detect(image: convertedCIImage)
      imageView.image = userPickedImage
    }
    imagePicker.dismiss(animated: true)
  }
}



