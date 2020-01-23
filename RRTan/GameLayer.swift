//
//  GameLayer.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class GameLayer: SKNode{
    
    let character = Character()
    let screenSize = UIScreen.main.bounds
    
    var spawnEnemyVelocity: TimeInterval = 2.2
    var lifeEnemyIncrease: UInt32 = 1
    
    override init() {
        super.init()
        character.position = CGPoint.zero
        character.shooting(layer: self)
        self.addChild(character)
        spawnEnemies()
        spawnUpLevel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     func touchDown(atPoint pos : CGPoint) {
    
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        character.moveCharacter(pos: pos)
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        character.jsMovementIsOver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
    
    func updateGameDifficult(){
        spawnEnemyVelocity -= 0.25
        lifeEnemyIncrease += 15
    }
    
    
    func spawnUpLevel(){
        let _ = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { (_) in
            let node = UpLevel()
            let xPos = CGFloat.random(in: -self.screenSize.width*0.8...self.screenSize.width*0.8)
            let yPos = CGFloat.random(in: -self.screenSize.height*0.8...self.screenSize.height*0.8)
            node.position = CGPoint(x: xPos, y: yPos)
            node.life = Int(arc4random()) % node.lifeRange
            self.addChild(node)
        }
    
    }
    
    func spawnEnemies(){
        let action1 = SKAction.run {
            let node = Enemy()
            node.life = arc4random() % node.lifeRange + self.lifeEnemyIncrease + 1
            node.color = node.colors.randomElement()!
            node.colorBlendFactor = 0.6
            
            let signNumber: [CGFloat] = [-1,1]
            var xPos = CGFloat.random(in: self.screenSize.width...self.screenSize.width*1.2)
            xPos *= signNumber.randomElement()!
            var yPos = CGFloat.random(in: -self.screenSize.height*1.2...self.screenSize.height*1.2)
            yPos *= signNumber.randomElement()!
            node.position = CGPoint(x: xPos, y: yPos)
            node.zPosition = -1
            self.addChild(node)
            let action2 = SKAction.move(to: self.character.position, duration: 40)
            node.run(action2)
        }
        let sequece = SKAction.sequence([action1,SKAction.wait(forDuration: spawnEnemyVelocity)])
        self.run(SKAction.repeatForever(sequece))
    }
    
    
}
