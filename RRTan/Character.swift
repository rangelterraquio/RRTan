//
//  Character.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode{
    
    
  var vector: CGVector = CGVector.zero
  var shootColor = UIColor.blue

  init() {
        let texture = SKTexture(imageNamed: "elephant")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.setScale(0.4)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shooting(layer: GameLayer){
        var realDest: CGPoint = CGPoint.zero
      
        let action1 = SKAction.run {[weak self] in
            // 2 - Set up initial location of projectile
            guard let self = self else {print("perdeu a referencia")
                return
            }
            
            
   

            
            
             let node = SKShapeNode(circleOfRadius: 15)
             node.fillColor = self.shootColor
             node.physicsBody = SKPhysicsBody(circleOfRadius:15)
//            node.physicsBody?.contactTestBitMask = PhysicsCategory.enemies
             node.physicsBody?.collisionBitMask = PhysicsCategory.enemies
             node.physicsBody?.mass = 0.01
             node.physicsBody?.restitution = 1.0
             node.position = self.position
             node.name = "projectil"
              
            print("vector \(self.vector)")
            let position = CGPoint(x: self.vector.dx * 10, y: self.vector.dy * 10)
            // 3 - Determine offset of location to projectile
            let offset = position - node.position
            
            // 5 - OK to add now - you've double checked position
            layer.addChild(node)
            
            // 6 - Get the direction of where to shoot
            let direction = offset.normalized()
            
            // 7 - Make it shoot far enough to be guaranteed off screen
            let shootAmount = direction * 100
            
            // 8 - Add the shoot amount to the current position
//            realDest = shootAmount + node.position
//            let actionMove = SKAction.move(to: realDest, duration: 1.5)
//            let actionMoveDone = SKAction.removeFromParent()
//            let sequece = SKAction.sequence([actionMove, actionMoveDone])
//            node.run(sequece)
            node.physicsBody?.applyImpulse(CGVector(dx: self.vector.dx * 20, dy:  self.vector.dy * 20))//applyImpulse(CGVector(dx: realDest.x, dy: realDest.y))
            
        }
         
      // 9 - Create the actions
     
        self.run(SKAction.repeatForever(SKAction.sequence([action1,SKAction.wait(forDuration: 0.5)])))
    }
    
    
    func moveCharacter(pos: CGPoint){
        self.vector = CGVector(dx: pos.x - self.position.x, dy: pos.y - self.position.y)
        
        let angle = atan2(vector.dy, vector.dx)
        
        self.zRotation = angle + CGFloat(90).degreesToradius()
        
        


        // Normalize the components
        let magnitude = sqrt(self.vector.dx*self.vector.dx+self.vector.dy*self.vector.dy)
        self.vector.dx /= magnitude
        self.vector.dy /= magnitude

//        // Create a vector in the direction of the bird
//        let vector = CGVector(dx:strength*dx, dy:strength*dy)
//
//        // Apply impulse
//        projectile.physicsBody?.applyImpulse(vector)
//
       
    }
    
}
