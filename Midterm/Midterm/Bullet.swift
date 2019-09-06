//
//  Bullet.swift
//  Midterm
//
//  Created by Alex Ushakou on 2019-07-03.
//  Copyright © 2019 Name Deleted. All rights reserved.
//

import Foundation
import SpriteKit

public class Bullet : SKSpriteNode {
    private var bulletTargetLocation : CGPoint?
    
    init(xPosition: CGFloat, yPosition: CGFloat) {
        let texture = SKTexture(imageNamed: "bullet.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.name = "bullet"
        self.size = CGSize(width: 50, height: 50)
        self.position = CGPoint(x: xPosition, y: yPosition)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
