//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func keyPressed(_ sender: UIButton) {
        Task { @MainActor in
            
            guard let title = sender.titleLabel?.text else {return}
            playSound(title)
            sender.alpha = 0.5
            do {
                try await Task.sleep(nanoseconds: 200_000_000)
            }
            catch {
                print(error.localizedDescription)
            }
            sender.alpha = 1.0
        }
    }
    
    
    func playSound(_ title: String) {
        guard let soundURL = Bundle.main.url(forResource: title, withExtension: "wav") else {return}
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    

}

