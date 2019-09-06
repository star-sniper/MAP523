//
//  Bullet.swift
//  Lab3
//
//  Created by Harshit Arora on 2019-05-29.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import Foundation
import UIKit
import simd

public class Bullet : UIImageView
{
   // var speed : CGFloat
    let img = UIImage(named: "Image")
    
    var speed : CGFloat?
    var timer: Timer?
    
    struct direction
    {
        var dir_x: CGFloat = 0
        var dir_y: CGFloat = 0
    }
    
    struct spawnPoint
    {
        var sp_x: CGFloat = 0
        var sp_y: CGFloat = 0
    }
    
    var sp = spawnPoint()
    var dr = direction()
    
    // constructor with user-defined speed, spawnPoint, and direction
    init(spd: CGFloat, spawnX: CGFloat, spawnY: CGFloat, directionU: CGFloat, directionV: CGFloat) {
        super.init(image: img)
        self.frame = CGRect(x: 20, y: 59, width: 50, height: 50)
        speed = spd
        sp = spawnPoint(sp_x: spawnX, sp_y: spawnY)
        dr = direction(dir_x: directionU, dir_y: directionV)
    }
    
    // default constructor
    init()
    {
        super.init(image: img)
        self.frame = CGRect(x: 20, y: 59, width: 50, height: 50)
        speed = 50
        sp = spawnPoint(sp_x: 0, sp_y: 0)
        dr = direction(dir_x: 170, dir_y: 210)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func start() {
       let spd = Double(1/speed!)
        timer = Timer.scheduledTimer(timeInterval: spd, target: self, selector: #selector(moveBullet), userInfo: nil, repeats: true)
    }
    
    // creates vector and moves bullet, and checks if bullet is off-screen; if so, stops timer and wipes bullet from memory
    @objc func moveBullet() {
        sp.sp_x += dr.dir_x
        sp.sp_y += dr.dir_y
        
        let f = simd_double2(x: Double(sp.sp_x), y: Double(sp.sp_y))
        let unit_vector_f = simd_normalize(f)
        
        self.frame.origin.x += CGFloat(unit_vector_f.x)
        self.frame.origin.y += CGFloat(unit_vector_f.y)
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        if (self.frame.origin.x > (width - self.frame.width) || self.frame.origin.x < 0 || self.frame.origin.y > (height - self.frame.height) || self.frame.origin.y < 0) {
            self.removeFromSuperview()
            timer!.invalidate()
        }
    }
}
