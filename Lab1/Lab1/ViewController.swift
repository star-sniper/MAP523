//
//  ViewController.swift
//  Lab1
//
//  Created by Harshit Arora on 2019-05-15.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var seconds : Int = 1
    var cur_sec : Int = 0
    var running : Bool = false
    var timer = Timer()
    
    @IBOutlet weak var timeTextB: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startTimerB: UIButton!
    @IBOutlet weak var pauseTimeB: UIButton!
    @IBOutlet weak var resetTimeB: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startTimeBtn(_ sender: Any)
    {
        let userInput = Int(timeTextB.text!);
        
        if(running == true)
        {
            seconds = cur_sec;
            startTimer();
        }
        
        if(running == false)
        {
           
            seconds = userInput! * 60;
            startTimer();
        }
        else
        {
            print("Enter number between 1-60");
        }
    }
    
    @IBAction func pauseTime(_ sender: Any)
    {
        running = true
        cur_sec = seconds
        timer.invalidate();
    }
    
    @IBAction func resetTime(_ sender: Any)
    {
        timer.invalidate()
        running = false
        seconds = 1
        timerLabel.text = "MM:SS"
    }
    
    @objc func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer()
    {
        print(seconds)
        if (seconds < 1)
        {
            timer.invalidate()
        }
        else
        {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @objc func timeString(time: TimeInterval) ->String
    {
        let min = Int(time) / 60 % 60
        let sec = Int(time) % 60
        return String(format:"%02i:%02i", min, sec)
    }
}

