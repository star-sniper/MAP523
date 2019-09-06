//
//  Lemming.swift
//  Lab5
//
//  Created by Harshit Arora on 2019-07-07.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import Foundation
import UIKit
import simd

public class Lemming : UIImageView
{
    let img = UIImage(named: "Lemming")
    let img2 = UIImage(named: "Bullet")
   
    
    
    init(xPos: CGFloat, yPos: CGFloat, w: CGFloat, h: CGFloat)
    {
        super.init(image: img)  //Calling the constructor of the parent
        self.frame = CGRect(x: xPos, y: yPos, width: w, height: h )
        let tmp = UITapGestureRecognizer(target: self, action: #selector(self.ff))
        self.addGestureRecognizer(tmp)
    }
    
    init()
    {
        super.init(image: img)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   

    @objc func ff()
    {
        print("Lemming start point \(self.frame.origin.x) :x y: \(self.frame.origin.y)");
        print("shooting a bullet");
        let tmp = Bullet(xPos: CGFloat(self.frame.origin.x) + 5, yPos: CGFloat(self.frame.origin.y), w: 30, h: 30, spd: 50)
        tmp.start()
        superview!.addSubview(tmp)
    }
}
