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
    
    
  var vector: CGVector = CGVector(dx: 10, dy: 10)
  var shootColor = UIColor.blue
  var shootingsPerSecond: CGFloat = 0.17
   let jtBack: SKSpriteNode = SKSpriteNode(imageNamed: "Joystick_Drt_01") //(imageNamed: "Joystick_Drt_01")
   let jtButtom: SKSpriteNode = SKSpriteNode(imageNamed: "Joystick_Drt_02")//(imageNamed: "Joystick_Drt_02")
   var joyStickAngle: CGFloat = 0.0
   var velocityX: CGFloat = 0.0
   var velocityY: CGFloat = 0.0
    var projectil : SKShapeNode!
    var isProjectilVisisble = false
    init() {
        let texture = SKTexture(imageNamed: "elephant")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemies
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.categoryBitMask = PhysicsCategory.character
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 100
        self.setScale(0.4)
        self.name = "character" 
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shooting(layer: SKNode){
        var realDest: CGPoint = CGPoint.zero
      
        let action1 = SKAction.run {[weak self] in
            // 2 - Set up initial location of projectile
            guard let self = self else {print("perdeu a referencia")
                return
            }
            
            
            
            
            self.projectil = SKShapeNode(circleOfRadius: 15)
            self.projectil.fillColor = self.shootColor
            self.projectil.physicsBody = SKPhysicsBody(circleOfRadius:15)
            self.projectil.physicsBody?.contactTestBitMask = PhysicsCategory.enemies | PhysicsCategory.projectil
            self.projectil.physicsBody?.collisionBitMask = PhysicsCategory.enemies | PhysicsCategory.collectible
            self.projectil.physicsBody?.categoryBitMask = PhysicsCategory.projectil
            self.projectil.physicsBody?.mass = 0.01
            self.projectil.physicsBody?.restitution = 1.0
            self.projectil.physicsBody?.affectedByGravity = false
            self.projectil.position = self.position
            self.projectil.name = "projectil"
            self.projectil.isHidden = self.isProjectilVisisble
              
        
            let position = CGPoint(x: self.vector.dx * 10, y: self.vector.dy * 10)
            // 3 - Determine offset of location to projectile
            let offset = position - self.projectil.position
            
            // 5 - OK to add now - you've double checked position
            layer.addChild(self.projectil)
            
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
            self.projectil.physicsBody?.applyImpulse(CGVector(dx: self.vector.dx * 14, dy:  self.vector.dy * 14))//applyImpulse(CGVector(dx: realDest.x, dy: realDest.y))
            
        }
         
      // 9 - Create the actions
     
        self.run(SKAction.repeatForever(SKAction.sequence([action1,SKAction.wait(forDuration: TimeInterval(shootingsPerSecond))])))
    }
    
    func specialPower(){
       // self.removeAllActions()
        let node = SKShapeNode(rectOf: CGSize(width: 50, height: UIScreen.main.bounds.height*1.65))
        node.fillColor = .black
        node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
        node.physicsBody?.contactTestBitMask = PhysicsCategory.enemies | PhysicsCategory.collectible
        node.physicsBody?.collisionBitMask = PhysicsCategory.None
        node.physicsBody?.categoryBitMask = PhysicsCategory.specialPower
//        node.physicsBody?.mass = 10
//        node.physicsBody?.restitution = 0.4
        node.physicsBody?.usesPreciseCollisionDetection = true
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = true
        node.name = "specialPower"
        node.position = CGPoint(x: 0, y: -node.frame.height/2)
        self.addChild(node)
//        self.removeAllActions()
        isProjectilVisisble = !false
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 10)])) {
            node.removeFromParent()
            //self.shooting(layer: self.parent!)
            self.isProjectilVisisble = false
        }
    }
    
    
    func moveCharacter(pos: CGPoint){
        // to criando um vetor subtraindo o centro do meu joystick da localização do toque
       let vector2 = CGVector(dx: pos.x - self.jtBack.position.x, dy: pos.y - self.jtBack.position.y)
       
       // atraves do vetor achamos o angulo q faz em relação ao eixo
       self.joyStickAngle = atan2(vector2.dy, vector2.dx)
        
        self.vector = CGVector(dx: pos.x - self.position.x, dy: pos.y - self.position.y)
        
        let angle = atan2(vector.dy, vector.dx)
        
        //self.zRotation = angle + CGFloat(90).degreesToradius()
        self.zRotation = joyStickAngle + CGFloat(90).degreesToradius()
        

        self.vector = vector2

        // Normalize the components
        let magnitude = sqrt(self.vector.dx*self.vector.dx+self.vector.dy*self.vector.dy)
        self.vector.dx /= magnitude
        self.vector.dy /= magnitude

//        // Create a vector in the direction of the bird
//        let vector = CGVector(dx:strength*dx, dy:strength*dy)
//
//        // Apply impulse
//        projectile.physicsBody?.applyImpulse(vector)
//         self.joyStickAngle = atan2(vector.dy, vector.dx)
     
//        self.zRotation = joyStickAngle
            //descobrir a distancia do toque com relação ao centro
            let distanceFromCenter = CGFloat((self.jtBack.frame.size.height/2))
            
            // calculo até onde o botão do centro pode ir (aqui onde eu irei fazer ele andar só pros lado; esse pi ajusta o problea de o joyStick
            // quando chega na ponta volta
            let distanceX = CGFloat(sin(self.joyStickAngle - CGFloat(Double.pi/2)) * distanceFromCenter)
            let distanceY = CGFloat(cos(self.joyStickAngle - CGFloat(Double.pi/2)) * distanceFromCenter)
            
            // faço o tratamento dessa posiçao
            if self.jtBack.frame.contains(pos){
                self.jtButtom.position = pos
            }else {
                jtButtom.position = CGPoint(x: self.jtBack.position.x - distanceX, y: self.jtBack.position.y + distanceY)
            }
            
    //        if aimTouched {
    //            self.jtButtom.position = touchLocation
    //        }

            // seta valecidade q o  personagem vai se mover
            self.velocityX = (self.jtButtom.position.x - self.jtBack.position.x)/5
            self.velocityY = (self.jtButtom.position.y - self.jtBack.position.y)/5
//
    }
    
    func jsMovementIsOver(){
          let action = SKAction.move(to: CGPoint(x: self.jtBack.position.x, y: self.jtBack.position.y), duration: 0.1)
          action.timingMode = .linear
          self.jtButtom.run(action)
          self.velocityX = 0.0
          self.velocityY = 0.0
      }
    
}
