//
//  GameScene.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var character : SKSpriteNode?
    
    private var posInitial: CGPoint = CGPoint.zero
    private var posFinal: CGPoint = CGPoint.zero
    private var vector: CGVector = CGVector.zero{
        didSet{
           
//            print("x magnitude \(vector.dx.magnitude)")
//            print("y magnitude \(vector.dy.magnitude)")
//
            
            
        }
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .gray
        setupCharacter()
        self.shoot2()
    }
    
    private func setupCharacter(){
        character = SKSpriteNode(imageNamed: "elephant")
        character?.setScale(0.4)
        if let char = character{
            char.position = CGPoint.zero
            self.addChild(char)
        }
       
        
    }
    
    
    private func shoot(vector: CGVector){
       
        
        let action = SKAction.run {
            let node = SKShapeNode(circleOfRadius: 15)
            node.fillColor = .blue
            node.physicsBody = SKPhysicsBody(circleOfRadius:15)
            node.position = self.character!.position
            self.addChild(node)
            node.run(SKAction.move(to: CGPoint(x: vector.dx * 100, y: vector.dy * 100), duration: 10))
           // node.physicsBody?.applyImpulse(vector)
            //node.physicsBody?.applyImpulse(CGVector.init(dx: vector.dx, dy: vector.dy))
            
        }
        let sequence = SKAction.sequence([action, SKAction.wait(forDuration: 0.5)])
        self.run(SKAction.repeatForever(sequence))
        
    }
    
    func shoot2(){
        var realDest: CGPoint = CGPoint.zero
      
        let action1 = SKAction.run {[weak self] in
            // 2 - Set up initial location of projectile
            guard let self = self else {print("perdeu a referencia")
                return
            }
            
             let node = SKShapeNode(circleOfRadius: 15)
             node.fillColor = .blue
             node.physicsBody = SKPhysicsBody(circleOfRadius:15)
             node.position = self.character!.position
              
            print("vector \(self.vector)")
            let position = CGPoint(x: self.vector.dx * 10, y: self.vector.dy * 10)
            // 3 - Determine offset of location to projectile
            let offset = position - node.position
            
            // 4 - Bail out if you are shooting down or backwards
          
            
            // 5 - OK to add now - you've double checked position
            self.addChild(node)
            
            // 6 - Get the direction of where to shoot
            let direction = offset.normalized()
            
            // 7 - Make it shoot far enough to be guaranteed off screen
            let shootAmount = direction * 1000
            
            // 8 - Add the shoot amount to the current position
            realDest = shootAmount + node.position
            let actionMove = SKAction.move(to: realDest, duration: 1.5)
            let actionMoveDone = SKAction.removeFromParent()
            let sequece = SKAction.sequence([actionMove, actionMoveDone])
            node.run(sequece)
        }
      
      
      // 9 - Create the actions
     
        self.run(SKAction.repeatForever(SKAction.sequence([action1,SKAction.wait(forDuration: 0.5)])))
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
        
        posInitial = character!.position
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        private double getDegreesFromTouchEvent(float x, float y){
//            double delta_x = x - (Screen Width) /2;
//            double delta_y = (Screen Height) /2 - y;
//            double radians = Math.atan2(delta_y, delta_x);
//
//            return Math.toDegrees(radians);
//        }
    // to criando um vetor subtraindo o centro do meu joystick da localização do toque
//        let vector = CGVector(dx: touchLocation.x - self.jtBack.position.x, dy: touchLocation.y - self.jtBack.position.y)
//
        // atraves do vetor achamos o angulo q faz em relação ao eixo
//        self.joyStickAngle = atan2(vector.dy, vector.dx)
        
//        posFinal.x = posInitial.x - pos.x
//        posFinal.y = posInitial.y - pos.y
//
//        let vector = CGVector(dx: posFinal.x, dy: posFinal.y)
        self.vector = CGVector(dx: pos.x - posInitial.x, dy: pos.y - posInitial.y)
        
        var angle = atan2(vector.dy, vector.dx)
        
//        if angle > 90 || angle < -90{
//            angle += 180
//        }

    
        
        if let node = character as SKSpriteNode?{
            node.zRotation = angle + CGFloat(90).degreesToradius()
        }
       
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}



