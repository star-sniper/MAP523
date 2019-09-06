//
//  GameScene.swift
//  Lab6
//
//  Created by Harshit Arora on 2019-06-12.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    var playerCategory: UInt32 = 0x1 << 1   // = 2
    var birdCategory: UInt32 = 0x1 << 2  // = 4
    var coinCategory: UInt32 = 0x1 << 3    // = 8
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createObjects()
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody

    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 4) {
            contact.bodyB.node?.removeFromParent()
        }
        if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 8) {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
        //print("no collision")
    }
    
    func createObjects() {
        let movePlayer = SKAction.applyForce(CGVector(dx: CGFloat(Double.random(in: 100 ... 500)), dy: CGFloat(Double.random(in: 100 ... 500)) ), duration: 3)
        
        let moveBird = SKAction.applyForce(CGVector(dx: CGFloat(Double.random(in: 100 ... 500)), dy: CGFloat(Double.random(in: 100 ... 500)) ), duration: 3)
        
        let moveCoin = SKAction.applyForce(CGVector(dx: CGFloat(Double.random(in: 100 ... 500)), dy: CGFloat(Double.random(in: 100 ... 500)) ), duration: 1)
        
        let player = SKSpriteNode(imageNamed: "Player")
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.allowsRotation = false
        
        player.size = CGSize(width: 200, height: 100)
        player.physicsBody?.affectedByGravity = false
        //player.physicsBody?.isDynamic = true
       // player.position = CGPoint(x: CGFloat(Double.random(in: -150 ... 150)), y: CGFloat(Double.random(in: -300 ... 300)))
        player.position = CGPoint(x: 0, y: -640)
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = birdCategory | coinCategory
        player.physicsBody?.collisionBitMask = birdCategory
        addChild(player)
        player.run(SKAction.repeatForever(movePlayer))
        
        
        let bird = SKSpriteNode(imageNamed: "Bird")
        bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
        bird.size = CGSize(width: 150, height: 100)
        
        bird.physicsBody?.affectedByGravity = false
        //bird.physicsBody?.isDynamic = true
        
         bird.position = CGPoint(x: 0, y: 0)
        //bird.position = CGPoint(x: CGFloat(Double.random(in: -150 ... 150)), y: CGFloat(Double.random(in: -300 ... 300)))
        bird.physicsBody?.categoryBitMask = birdCategory
        bird.physicsBody?.contactTestBitMask = coinCategory
        bird.physicsBody?.collisionBitMask = playerCategory
        addChild(bird)
         bird.run(SKAction.repeatForever(moveBird))
        
        let coin = SKSpriteNode(imageNamed: "Coin")
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        
        coin.size = CGSize(width: 100, height: 90)
        coin.physicsBody?.affectedByGravity = false
         coin.position = CGPoint(x: 0, y: 640)
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = birdCategory
        coin.physicsBody?.collisionBitMask = birdCategory | playerCategory
        addChild(coin)
        coin.run(SKAction.repeatForever(moveCoin))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
}
