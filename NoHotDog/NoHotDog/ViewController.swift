//
//  ViewController.swift
//  SeaFood
//
//  Created by CEMRE YARDIM on 17.11.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  
  let lookingFor = "hotdog"
  
  let imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary //.camera
    imagePicker.allowsEditing = false
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      fatalError("Cannot pick original image")
    }
    
    imageView.image = pickedImage
    
    guard let ciImage = CIImage(image: pickedImage) else {
      fatalError("Cannot convert UI image into CI image")
    }
    
    detect(image: ciImage)
    
    imagePicker.dismiss(animated: true)
  }
  
  func detect(image: CIImage) {
    
    guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: MLModelConfiguration()).model) else { fatalError("Loading CoreML model failed")
    }
    let request = VNCoreMLRequest(model: model) { [weak self] vnRequest, error in
      guard let results = vnRequest.results as? [VNClassificationObservation] else {
        fatalError("model failed to process image")
      }
      if let firstResult = results.first {
        if firstResult.identifier.contains(self?.lookingFor ?? "") {
          self?.navigationItem.title = self?.lookingFor ?? ""
        } else {
          self?.navigationItem.title = "no \(self?.lookingFor ?? "")"
        }
      }
    }
    
    let handler = VNImageRequestHandler(ciImage: image)
    
    do {
      try handler.perform([request])
    } catch {
      print(error.localizedDescription)
    }
    
  }

  @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    present(imagePicker, animated: true, completion: nil)
  }
  
}

