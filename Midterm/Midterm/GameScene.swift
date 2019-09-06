//
//  GameScene.swift
//  Midterm
//
//  Created by Alex Ushakou on 2019-07-02.
//  Copyright © 2019 Name Deleted. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var bulletCategory: UInt32 = 0x1 << 1   // = 2
    private var birdCategory: UInt32 = 0x1 << 2     // = 4
    private var eggCategory: UInt32 = 0x1 << 3     // = 8
    private var hunterCategory: UInt32 = 0x1 << 4     // = 16
    
    private var score = 0
    private var health = 100
    private var gameOver = false
    
    private var timeOfLastBirdSpawn: CFTimeInterval = 0.0
    private var timePerBirdSpawn: CFTimeInterval = 1.0
    
    private var scoreLabel : SKLabelNode?
    private var healthLabel : SKLabelNode?
    private var gameOverLabel : SKLabelNode?
    
    private var initialTouchLocation : CGPoint?
    
    private var hunter : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        hunter = childNode(withName: "hunter") as? SKSpriteNode
        hunter!.physicsBody?.categoryBitMask = hunterCategory
        hunter!.physicsBody?.contactTestBitMask = bulletCategory | birdCategory | eggCategory
        hunter!.physicsBody?.collisionBitMask = 0
        
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel!.text = "Score: 0"
        scoreLabel!.fontColor = UIColor.black
        scoreLabel!.fontName = "AvenirNext-Bold"
        scoreLabel!.fontSize = 30
        
        healthLabel = childNode(withName: "healthLabel") as? SKLabelNode
        healthLabel!.text = "Health: 100"
        healthLabel!.fontColor = UIColor.black
        healthLabel!.fontName = "AvenirNext-Bold"
        healthLabel!.fontSize = 30
    }

    func spawnBird() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let xPosition = CGFloat(Int(arc4random_uniform(UInt32((screenWidth / 2) - (screenWidth / -2) + 1))) + Int(screenWidth / -2))
        let yPosition = screenHeight / 2
        
        let bird = Bird(xPosition: xPosition, yPosition: yPosition)
        
        bird.physicsBody?.categoryBitMask = birdCategory
        bird.physicsBody?.contactTestBitMask = bulletCategory | eggCategory | hunterCategory
        bird.physicsBody?.collisionBitMask = birdCategory
        
        addChild(bird)
        
        bird.run(SKAction.repeatForever(SKAction.sequence([SKAction.run { self.spawnEgg(spawnLocation: bird.position) }, SKAction.run { bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -10)) }, SKAction.wait(forDuration: TimeInterval(1)), SKAction.run { self.spawnEgg(spawnLocation: bird.position)}, SKAction.run { bird.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -10)) }, SKAction.wait(forDuration: TimeInterval(1))])))
    }
    
    func spawnEgg(spawnLocation: CGPoint) {
        let egg = SKSpriteNode(imageNamed: "egg.png")
        
        egg.name = "egg"
        egg.size = CGSize(width: 50, height: 50)
        
        egg.position = CGPoint(x: spawnLocation.x, y: spawnLocation.y)
        egg.physicsBody = SKPhysicsBody(rectangleOf: egg.size)
        egg.physicsBody?.affectedByGravity = false
        egg.physicsBody?.isDynamic = true
        egg.physicsBody?.categoryBitMask = eggCategory
        egg.physicsBody?.contactTestBitMask = bulletCategory | birdCategory | hunterCategory
        egg.physicsBody?.collisionBitMask = eggCategory
        
        addChild(egg)
        
        egg.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -50))
    }
    
    func spawnBullet() {
        let xPosition = self.hunter!.position.x
        let yPosition = self.hunter!.position.y
        
        let bullet = Bullet(xPosition: xPosition, yPosition: yPosition)

        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = birdCategory | eggCategory
        bullet.physicsBody?.collisionBitMask = bulletCategory
        
        addChild(bullet)
        
        bullet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
    }
    
    func endGame() {
        self.gameOver = true
        showGameOverLabel()
    }
    
    func showGameOverLabel() {
        gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel!.fontColor = UIColor.black
        gameOverLabel!.fontSize = 60
        gameOverLabel!.fontName = "AvenirNext-Bold"
        gameOverLabel!.name = "gameOverLabel"
        gameOverLabel!.position = CGPoint(x: 0, y: 200)
        addChild(gameOverLabel!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if (!self.gameOver) {
                if (touchLocation.y > 0) {
                    spawnBullet()
                } else {
                    self.hunter?.position.x = touchLocation.x
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if (!self.gameOver && self.atPoint(touchLocation).name == "hunter") {
                self.hunter?.position.x = touchLocation.x
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == bulletCategory) {
            if (contact.bodyB.categoryBitMask == birdCategory) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                self.score += 10
                self.scoreLabel?.text = "Score: " + String(self.score)
            } else if (contact.bodyB.categoryBitMask == eggCategory) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
            }
        } else if (contact.bodyA.categoryBitMask == hunterCategory) {
            if (contact.bodyB.categoryBitMask == birdCategory || contact.bodyB.categoryBitMask == eggCategory) {
                contact.bodyB.node?.removeFromParent()
                if (self.health != 0) {
                    self.health -= 10
                    self.healthLabel?.text = "Health: " + String(self.health)
                }
            }
        } else if (contact.bodyA.categoryBitMask == birdCategory) {
            if (contact.bodyB.categoryBitMask == bulletCategory) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                self.score += 10
                self.scoreLabel?.text = "Score: " + String(self.score)
            } else if (contact.bodyB.categoryBitMask == hunterCategory) {
                contact.bodyA.node?.removeFromParent()
                if (self.health != 0) {
                    self.health -= 10
                    self.healthLabel?.text = "Health: " + String(self.health)
                }
            }
        } else if (contact.bodyA.categoryBitMask == eggCategory) {
            if (contact.bodyB.categoryBitMask == bulletCategory) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                self.score += 10
                self.scoreLabel?.text = "Score: " + String(self.score)
            } else if (contact.bodyB.categoryBitMask == hunterCategory) {
                contact.bodyA.node?.removeFromParent()
                if (self.health != 0) {
                    self.health -= 10
                    self.healthLabel?.text = "Health: " + String(self.health)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (!self.gameOver) {
            if (self.health == 0) {
                endGame()
            } else {
                if (currentTime - self.timeOfLastBirdSpawn > self.timePerBirdSpawn) {
                    spawnBird()
                    self.timeOfLastBirdSpawn = currentTime
                }
            }
        }
        
        enumerateChildNodes(withName: "SKSpriteNode") {
            node, _ in

            if (node.name == "bird" || node.name == "egg") {
                if (node.position.y < (UIScreen.main.bounds.height / -1.5)) {
                    node.removeFromParent()
                }
            } else if (node.name == "bullet") {
                if (node.position.y > (UIScreen.main.bounds.height / 1.5)) {
                    node.removeFromParent()
                }
            }
        }
    }
}
