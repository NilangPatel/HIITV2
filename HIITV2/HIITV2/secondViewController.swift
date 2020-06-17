//
//  secondViewController.swift
//  HIITV2
//
//  Created by Nilang Patel on 2020-06-11.
//  Copyright © 2020 Nilang Patel. All rights reserved.
//

import UIKit
import AVFoundation

class secondViewController: UIViewController {

    let loopSeconds = seconds
    let looprestSeconds = restSeconds
    var loopCounter = 0
    let looptotal = loop
    
    var startSound = AVAudioPlayer()
    
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var loopCounterLabel: UILabel!
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func startAction(_ sender: UIButton) {
        
        // associating the labels with the values established in ViewController
        startOutlet.isHidden = true
        pauseOutlet.isHidden = false
        
        activeLabel.text = "ACTIVE: " + String(seconds)
        restLabel.text = "REST: " + String(restSeconds)
        loopCounterLabel.text = String(loopCounter) + " / " + String(looptotal)
        
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondViewController.count), userInfo: nil, repeats: true)

    }
    
    //exercise timer
    @objc func count(){
        
        if(seconds > 0){
            seconds -= 1
            activeLabel.text = "ACTIVE: " + String(seconds)
            }
        
        if (seconds == 3){
            startSound.play()
        }
            // stopping the exercise timer and firing the rest timer
        else if (seconds == 0) {
            startSound.stop()
            countdown.invalidate()
            restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondViewController.resting), userInfo: nil, repeats: true)
        }
    }
    
    
    //rest timer action once the exercise timer finishes
    @objc func resting(){
        restSeconds -= 1
        restLabel.text = "REST: " + String(restSeconds)
        
        if (restSeconds == 3){
            startSound.currentTime = 0
            startSound.play()
        }
        
        if (restSeconds == 0){
            restTimer.invalidate()
            looper()
        }
    }
   
    // this will run the timer multiple times until the selected repeats are met
    func looper(){
        if (seconds == 0 && restSeconds == 0){
           seconds = Int(loopSeconds)
            activeLabel.text = String(seconds)
            
            restSeconds = Int(looprestSeconds)
            restLabel.text = String(restSeconds)
            
            loop -= 1
            loopCounter += 1
            
            loopCounterLabel.text = String(loopCounter) + " / " + String(looptotal)
            
            countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondViewController.count), userInfo: nil, repeats: true)
            
            if (loop == 0 && loopCounter == looptotal){
               
                countdown.invalidate()
            }
        }
    }
    
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBAction func pauseAction(_ sender: UIButton) {
        
        // allows timer to be paused and started again at the same values
        
        countdown.invalidate()
        restTimer.invalidate()
        
        startOutlet.isHidden = false
        pauseOutlet.isHidden = true
        
        startSound.stop()
        
        }
    
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stopAction(_ sender: UIButton) {
        countdown.invalidate()
        restTimer.invalidate()
        stopOutlet.isHighlighted = true
       
        startOutlet.isHidden = false
        pauseOutlet.isHidden = true
     
        // resetting values for the timer once stop button is pressed
        
        seconds = loopSeconds
        restSeconds = looprestSeconds
        loopCounter = 0
        
        activeLabel.text = "ACTIVE: " + String(seconds)
        restLabel.text = "REST: " + String(restSeconds)
        loopCounterLabel.text = String(loopCounter) + " / " + String(looptotal)
        
        startSound.stop()
        startSound.currentTime = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Active "
       
        // button design on "Active" page
        startOutlet.buttondesign()
        startOutlet.backgroundColor = UIColor.white
        
        pauseOutlet.buttondesign()
        pauseOutlet.backgroundColor = UIColor.white
        
        stopOutlet.buttondesign()
        stopOutlet.backgroundColor = UIColor.white
        
        do{
            startSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "START", ofType: "mp3")!))
            startSound.prepareToPlay()
        }catch{
            print(error)
        }
        
    }
}
