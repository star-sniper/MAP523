//
//  ViewController.swift
//  animation
//
//  Created by HARSHIT ARORA on 2019-05-21.
//  Copyright © 2019 HARSHIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgBox: UIImageView!
    @IBOutlet weak var playerImgBox: UIImageView!
    @IBOutlet weak var btnRun: UIButton!
    @IBOutlet weak var btnWalk: UIButton!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var stepsLabel: UILabel!
    
    var iterator : Int = 1
    let frameMaxX = UIScreen.main.bounds.size.width
    let frameMaxY = UIScreen.main.bounds.size.height
    var xCord : Int = 0
    var yCord : Int = 0
    var XDirection : Int = 1
    var YDirection : Int = 1
    var animationCycle:Timer?
    var totalSteps : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(frameMaxX)
        print(frameMaxY)
        print(playerImgBox.frame.origin.y)
        print(playerImgBox.frame.origin.x)
    }
    
    @IBAction func btnWalkTouchEv(_ sender: Any)
    {
        animationCycle?.invalidate()
        xCord = Int(xTextField.text!)!
        yCord = Int(yTextField.text!)!
        if(CGFloat(xCord) < frameMaxX || CGFloat(yCord) < frameMaxY)
        {
        animationCycle = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func btnRunTouch(_ sender: Any)
    {
        animationCycle?.invalidate()
        xCord = Int(xTextField.text!)!
        yCord = Int(yTextField.text!)!
        if(CGFloat(xCord) < frameMaxX || CGFloat(yCord) < frameMaxY)
        {
            animationCycle = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateImage()
    {
        if(playerImgBox.frame.origin.x == CGFloat(xCord) && playerImgBox.frame.origin.y == CGFloat(yCord))
        {
            animationCycle?.invalidate()
            //playerImgBox.image = UIImage(named: "frame-1.png")
        }
        else
        {
            playerImgBox.image = UIImage(named: "frame-\(iterator).png")
 
              iterator += 1
            if (iterator == 5){
                iterator = 1
            }
            
            if(iterator % 2 == 1){
                totalSteps += 1
                stepsLabel.text! = String(totalSteps)
            }
            
            
            
            if(playerImgBox.frame.origin.x > CGFloat(xCord)){
                XDirection = -1
            } else if(playerImgBox.frame.origin.x < CGFloat(xCord)) {
                XDirection = 1
            } else{
                XDirection = 0
            }
            
            if(playerImgBox.frame.origin.y > CGFloat(yCord)){
                YDirection = -1
            } else if(playerImgBox.frame.origin.y < CGFloat(yCord)){
                YDirection = 1
            } else{
                YDirection = 0
            }
            
            // Move character at this rate and direction
            playerImgBox.frame.origin.x += CGFloat(10*XDirection)
            playerImgBox.frame.origin.y += CGFloat(10*YDirection)
        }
       
    }


}

