//
//  Bullet.swift
//  Lab5
//
//  Created by Harshit Arora on 2019-06-05.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//
import Foundation
import UIKit
import simd

public class Bullet : UIImageView
{
    // var speed : CGFloat
    let img = UIImage(named: "Bullet")

    var speed : CGFloat?
    var timer: Timer?
    
    // constructor with user-defined speed, spawnPoint, and direction
    init(xPos: CGFloat, yPos: CGFloat, w: CGFloat, h: CGFloat, spd: CGFloat)
    {
        super.init(image: img)
        print("Bullet spawn point \(xPos) :x y: \(yPos)");
        self.frame = CGRect(x: xPos, y: yPos, width: w, height: h)
        speed = spd
    }
    
    // default constructor
   init()
    {
        super.init(image: img)
        speed = 50
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
      //  print("Bullet start spawn point \(sp.sp_x) :x y: \(sp.sp_y)");
        let spd = Double(1/speed!)
     timer = Timer.scheduledTimer(timeInterval: spd, target: self, selector: #selector(moveBullet), userInfo: nil, repeats: true)
    }
    
    @objc func moveBullet() {
        self.frame.origin.x += 5//CGFloat(unit_vector_f.x)
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        for subview in superview!.subviews
        {
            if (self.frame.origin.x > (width - self.frame.width) || self.frame.origin.x < 0 || self.frame.origin.y > (height - self.frame.height) || self.frame.origin.y < 0)
            {
                if subview is Enemy
                {
                    subview.removeFromSuperview()
                }
                self.removeFromSuperview()
                timer!.invalidate()
            }
        }
    }
}
