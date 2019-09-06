//
//  Lemming.swift
//  Lab4
//
//  Created by Harshit Arora on 2019-06-04.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//
import Foundation
import UIKit
import simd

public class Lemming : UIImageView
{
    let img = UIImage(named: "Image1")
    
    private var iterator = 1
    var timer: Timer?
    var destination: CGPoint?
    
    init(xPos: CGFloat, yPos: CGFloat, w: CGFloat, h: CGFloat)
    {
        super.init(image: img)  //Calling the constructor of the parent

        self.frame = CGRect(x: xPos, y: yPos, width: w, height: h )
    }
    
    init()
    {
        super.init(image: img)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(xPos: CGFloat, yPos: CGFloat){
        
        self.frame.origin = CGPoint(x:  xPos, y:  yPos)
    }
    
    func walk(des: CGPoint, speed: CGFloat)
    {
        self.destination = des
        let spd = Double(1/speed)
        timer = Timer.scheduledTimer(timeInterval: spd, target: self, selector: #selector(animateToward), userInfo: nil, repeats: true)
    }
    
    @objc private func animateToward()
    {
        self.image = UIImage(named: "Image\(iterator).png")
        iterator += 1
        if (iterator == 5){
            iterator = 1
        }
        
        let current_pos = self.frame.origin
      //  print("Current pos: \(current_pos.x) and \(current_pos.y)")
        //print("Destination : \(self.destination!.x) and \(self.destination!.y)")
        //Calculate the vector toward the destination I want to reach
        let moveToward = CGVector(dx: self.destination!.x - current_pos.x, dy: self.destination!.y - current_pos.y)
     //   print("Move toward: \(moveToward.dx) and \(moveToward.dy)")
        //Shrink the length of the moveToward vector to length=1. This process is called "Normalization"
        var unit_vector = simd_normalize(simd_double2(x: Double(moveToward.dx), y: Double(moveToward.dy)))
     //   print("Unit vector : \(unit_vector.x) and \(unit_vector.y)")
        //Update the position along the unit_vector
         self.setPosition(xPos: self.frame.origin.x + CGFloat(unit_vector.x), yPos: self.frame.origin.y + CGFloat(unit_vector.y))
     //   print("Current pos: \(self.frame.origin.x) and \(self.frame.origin.y)")
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        if (self.frame.origin.x > (width - self.frame.width) || self.frame.origin.y > (height - self.frame.height)) {
            
           timer!.invalidate()
           self.removeFromSuperview()
            // print(" final Current pos: \(current_pos.x) and \(current_pos.y)")
            }
    }
}
