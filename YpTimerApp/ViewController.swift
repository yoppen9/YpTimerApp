//
//  ViewController.swift
//  YpTimerApp
//
//  Created by 山岸善将 on 2021/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    var timer : Timer?
    
    var count = 0
    
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let settings = UserDefaults.standard
        
        settings.register(defaults: [settingKey : 10])
        
    }


    @IBOutlet weak var countDownLabel: UILabel!
    
    
    @IBAction func settingButtonAction(_ sender: Any) {
        
        if let nowTimer = timer {
            
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        
        performSegue(withIdentifier: "goSetting", sender: nil)
        
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
        if let noeTimer = timer {
            
            if noeTimer.isValid == true {
                noeTimer.invalidate()
            }
            
        }
        
    }
    
    
    func displayUpdate() -> Int {
        
        let settings = UserDefaults.standard
        
        let timerValue = settings.integer(forKey: settingKey)
        
        let remainCount = timerValue - count
        
        countDownLabel.text = "残り\(remainCount)秒"
        
        return remainCount
        
    }
    
    
    @objc func timerInterrupt(_ timer: Timer) {
        
        count += 1
        
        if displayUpdate() <= 0 {
            count = 0
            timer.invalidate()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        _  = displayUpdate()
    }
    
}

