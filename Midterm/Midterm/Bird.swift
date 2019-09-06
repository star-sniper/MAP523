//
//  Bird.swift
//  Midterm
//
//  Created by Alex Ushakou on 2019-07-03.
//  Copyright © 2019 Alex Ushakou. All rights reserved.
//

import Foundation
import SpriteKit

public class Bird : SKSpriteNode {
    
    init(xPosition: CGFloat, yPosition: CGFloat) {
        let texture = SKTexture(imageNamed: "bird.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.name = "bird"
        self.size = CGSize(width: 100, height: 100)
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
