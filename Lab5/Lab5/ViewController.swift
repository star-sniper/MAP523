//
//  ViewController.swift
//  Lab5
//
//  Created by Harshit Arora on 2019-06-05.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       /* let imgViewX = imgView.frame.origin.x + 50
        let imgViewY = imgView.frame.origin.y
        
         //var tmp = Bullet(spd: 100, spawnX: imgViewX, spawnY: imgViewY, directionU: imgViewY, directionV: 0)
       var tmp = Bullet()
        tmp.start()
        
        self.view.addSubview(tmp)
        */
        let touch = UITapGestureRecognizer(target: self, action: #selector(tapGest))
        self.view.addGestureRecognizer(touch)
    }
    
    
    @IBAction func tapGest(touch: UITapGestureRecognizer) {
        
        
        let touchP = touch.location(in: self.view)
        let lem = Lemming(xPos: CGFloat(touchP.x), yPos: CGFloat(touchP.y), w: 70, h: 70)
        let enemy = Enemy(xPos: CGFloat(touchP.x), yPos: CGFloat(touchP.y), w: 70, h: 70)
      //  let bul = Bullet(xPos: CGFloat(touchP.x), yPos: CGFloat(touchP.y), w: 30, h: 30, spd: 30)
        //print("\(touchP.x) :x y: \(touchP.y)");
        
        if(CGFloat(touchP.x) > 160)
        {
            self.view.addSubview(enemy)
        }
        else
        {
            print("ViewController Touch location \(touchP.x) :x y: \(touchP.y)");
            self.view.addSubview(lem)
            for subview in self.view.subviews
            {
                if subview is Lemming
                {
                    lem.ff()
                }
            }
        }
    }
}

