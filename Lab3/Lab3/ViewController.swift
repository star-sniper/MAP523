//
//  ViewController.swift
//  Lab3
//
//  Created by Harshit Arora on 2019-05-29.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //var tmp = Bullet(spd: 30, spawnX: 0, spawnY: 0, directionU: 170, directionV: 210)
        var tmp = Bullet()
        tmp.start()
        self.view.addSubview(tmp)
    }


}

