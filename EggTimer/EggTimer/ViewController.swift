//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let hardnessTimes = ["Soft":300, "Medium":420, "Hard":720]
    var timeLeft = 0
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer?.invalidate()
        bar.progress = 0.0
        
        guard let hardness = sender.titleLabel?.text else {return}
        
        titleLabel.text = "Cooking \(hardness) egg."
        
        if hardnessTimes.keys.contains(hardness) {
            self.timeLeft = hardnessTimes[hardness] ?? 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                [weak self] timer in
                
                
                self?.timeLeft -= 1
                
                let progressTime = Float((self?.hardnessTimes[hardness] ?? 0) - (self?.timeLeft ?? 0)) / Float(self?.hardnessTimes[hardness] ?? 0)
                self?.bar.progress = progressTime
                
                
                if self?.timeLeft ?? 0 > 0 {
                    //print(self?.timeLeft ?? "")
                } else {
                    
                    timer.invalidate()
                    self?.playSound()
                    DispatchQueue.main.async {
                        self?.titleLabel.text = "DONE!"
                    }
                }
            }
        } else {
            print("Error")
        }
    
    }
    
    
    func playSound() {
            guard let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    


}
