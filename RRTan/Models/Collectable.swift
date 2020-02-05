//
//  Collectible.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 22/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class Collectable: SKSpriteNode{
    
    var life: Int = 1{
        didSet{
            if life == 0 {
                self.removeFromParent()
            }
        }
    }
    var lifeRange: Int = 10
    
    init(textureName: String) {
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.physicsBody = textureName == "levelUP" ? SKPhysicsBody(circleOfRadius: 25) : SKPhysicsBody(rectangleOf: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 30
        self.physicsBody?.collisionBitMask = PhysicsCategory.projectil
        self.physicsBody?.contactTestBitMask = PhysicsCategory.projectil | PhysicsCategory.specialPower
        self.physicsBody?.categoryBitMask = PhysicsCategory.collectible
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
