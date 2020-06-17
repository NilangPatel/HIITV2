//
//  ViewController.swift
//  HIITV2
//
//  Created by Nilang Patel on 2020-06-11.
//  Copyright © 2020 Nilang Patel. All rights reserved.
//

import UIKit

var seconds = 30
var restSeconds = 10
var loop = 0

var countdown = Timer()
var restTimer = Timer()

class ViewController: UIViewController {

    @IBOutlet weak var activeSetting: UILabel!
    @IBOutlet weak var activeSliderO: UISlider!
    @IBAction func activeSliderA(_ sender: UISlider) {
        seconds = Int(sender.value)
        activeSetting.text = String(seconds)
    }
    
    @IBOutlet weak var restSetting: UILabel!
    @IBOutlet weak var restSliderO: UISlider!
    @IBAction func restSliderA(_ sender: UISlider) {
        restSeconds = Int(sender.value)
        restSetting.text = String(restSeconds)
    }
    
    @IBOutlet weak var loopSetting: UILabel!
    @IBOutlet weak var loopStepperO: UIStepper!
    @IBAction func loopStepperA(_ sender: UIStepper) {
         loop = Int(sender.value)
        loopSetting.text = String(loop)
        
    }
    
    @IBOutlet weak var readyOutlet: UIButton!
    @IBAction func readyAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Circuit Setting"
        
        // redo this, UI does not work exactly
        readyOutlet.backgroundColor = UIColor.white
        readyOutlet.buttondesign()
    }


}

extension UIButton{
// the button dimensions are that of a square (56 x 56) and the corner radius makes it a circle
    func buttondesign(){
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 4)
    }
    
}
