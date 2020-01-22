//
//  Enemies.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    let colors: [UIColor] = [.red,.blue, .green]
    var labelLife = SKLabelNode(text: "0")
    
    var delegate: HudDelegate? = nil
    var life: UInt32 = 100 {
        didSet{
            if life == 0 {
                self.removeFromParent()
            }
            labelLife.text = "\(life)"
        }
    }
    var lifeRange: UInt32 = 15
    
    
    init() {
        let texture = SKTexture(imageNamed: "squaree")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        self.physicsBody?.contactTestBitMask = PhysicsCategory.projectil | PhysicsCategory.character
        self.physicsBody?.collisionBitMask = PhysicsCategory.projectil | PhysicsCategory.character
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemies
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.mass = 2
        self.physicsBody?.isDynamic = false
        self.setScale(0.7)
        labelLife.color = .black
        labelLife.colorBlendFactor = 1.0
        labelLife.fontSize = 40
        labelLife.position = CGPoint(x: 0.5, y: 0.5)
        self.addChild(labelLife)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
