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
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
  
    let eggTimes: [String: Int] = ["Soft": 300, "Medium": 5, "Hard": 720]
    
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 0
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        titleLabel.text = hardness

        totalTime = eggTimes[hardness]!

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            }
    
    @objc func updateCounter() {

        if secondsPassed <= totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            progressBar.progress = Float(percentageProgress)
            
            secondsPassed += 1
        } else {
            titleLabel.text = "DONE!"
            timer.invalidate()
            playSound()
        }
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
