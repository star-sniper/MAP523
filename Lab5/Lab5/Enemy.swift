//
//  Enemy.swift
//  Lab5
//
//  Created by Harshit Arora on 2019-07-07.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import Foundation
import UIKit
import simd

public class Enemy : UIImageView
{
    let img = UIImage(named: "Enemy")
    
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
    
}
