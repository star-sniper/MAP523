//
//  ViewController.swift
//  Lab4
//
//  Created by Harshit Arora on 2019-05-29.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    //var lemmings[] = Lemming(xPos: 0, yPos: 0, w: 50, h: 50)
    var lemmings  = [Lemming]()
    var array_counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panPiece))
         self.view.addGestureRecognizer(pan)
        let touch = UITapGestureRecognizer(target: self, action: #selector(tapGest))
        self.view.addGestureRecognizer(touch)
    
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapGest(touch: UITapGestureRecognizer) {
        let touchP = touch.location(in: self.view)
       // let x = arc4random_uniform(UInt32(width))
        //let y = arc4random_uniform(UInt32(height))
        let lem = Lemming(xPos: CGFloat(touchP.x), yPos: CGFloat(touchP.y), w: 70, h: 70)
      
        lemmings.append(lem)
        self.view.addSubview(lem)
        array_counter += 1
    }
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    @IBAction func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
        //print("function is called")
  
       
        
        guard gestureRecognizer.view != nil else {return}
        
        
        let piece = gestureRecognizer.view!
        
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            print("Began")
            self.initialCenter = piece.center
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state == .ended {
            // Add the X and Y translation to the view's original position.
            //let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            //piece.center = newCenter
            print("Ended")
            
            print("Moving to: \(translation.x) and \(translation.y)")
            
            let bounds = UIScreen.main.bounds
            let width = bounds.size.width
            let height = bounds.size.height
           // lemmings.walk(des: CGPoint(x: translation.x, y: translation.y), speed: 50)
            
          
            for i in 0..<array_counter
            {
                  let spd = arc4random_uniform(100) + 100
                lemmings[i].walk(des: CGPoint(x: translation.x, y: translation.y), speed: CGFloat(spd))
            }
            
          
            
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
    }
}

