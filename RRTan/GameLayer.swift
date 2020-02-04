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
    
    //com essas 2 properties eu verifico se tinha um coletável na hora q o jogador pressionou pause
    var isCollectibleActive = false
    var isSpecialPowerActive = false
    var isAdstoLiveUsed = false
    override init() {
        super.init()
        character.position = CGPoint.zero
        character.shooting(layer: self)
        self.addChild(character)
        spawnEnemies()
        spawnUpLevel()
        spawnSpecialPower()
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
        var node: Collectable!
        let action1 = SKAction.run {
            node = Collectable(textureName: "levelUP")
            self.isCollectibleActive = true
            let xPos = CGFloat.random(in: -self.screenSize.width*0.7...self.screenSize.width*0.7)
            let yPos = CGFloat.random(in: -self.screenSize.height*0.7...self.screenSize.height*0.7)
            node.position = CGPoint(x: xPos, y: yPos)
            node.life = Int(arc4random()) % node.lifeRange
            node.name = "levelUP"
            self.addChild(node)
        }
        let action2 = SKAction.run {
            node.removeFromParent()
        }
        let sequence = SKAction.sequence([SKAction.wait(forDuration: TimeInterval.random(in: 15...30)),action1, SKAction.wait(forDuration: 10),action2])
        self.run(SKAction.repeatForever(sequence), withKey: "levelUP")
        
        
    
    }
    
    func spawnSpecialPower(){
        var node: Collectable!

        let action1 = SKAction.run {
            node = Collectable(textureName: "specialPower")
            self.isSpecialPowerActive = true
            let xPos = CGFloat.random(in: -self.screenSize.width*0.7...self.screenSize.width*0.7)
            let yPos = CGFloat.random(in: -self.screenSize.height*0.7...self.screenSize.height*0.7)
            node.position = CGPoint(x: xPos, y: yPos)
            node.life = Int(arc4random()) % node.lifeRange
            node.name = "specialPower"
            self.addChild(node)
        }
        let action2 = SKAction.run {
            node.removeFromParent()
        }
        let sequence = SKAction.sequence([SKAction.wait(forDuration: TimeInterval.random(in: 5...15)),action1, SKAction.wait(forDuration: 9),action2])
        self.run(SKAction.repeatForever(sequence), withKey: "specialPower")
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
        
        let action2 = SKAction.run {
            let node = Enemy(triangle: "triangle")
            node.life = arc4random() % node.lifeRange + self.lifeEnemyIncrease + 1
          
            let signNumber: [CGFloat] = [-1,1]
            var xPos = CGFloat.random(in: self.screenSize.width...self.screenSize.width*1.2)
            xPos *= signNumber.randomElement()!
            var yPos = CGFloat.random(in: -self.screenSize.height*1.2...self.screenSize.height*1.2)
            yPos *= signNumber.randomElement()!
            node.position = CGPoint(x: xPos, y: yPos)
            node.zPosition = -1
            self.addChild(node)
            let action2 = SKAction.move(to: self.character.position, duration: 35)
            let action3 = SKAction.rotate(byAngle: CGFloat(360).degreesToradius(), duration: 5)
            let repeatForever = SKAction.repeatForever(action3)
            node.run(SKAction.group([action2,repeatForever]))
        }
        let sequece1 = SKAction.sequence([action1,SKAction.wait(forDuration: spawnEnemyVelocity)])
        self.run(SKAction.repeatForever(sequece1))
        let sequece2 = SKAction.sequence([action2,SKAction.wait(forDuration: spawnEnemyVelocity * 1.8)])
        self.run(SKAction.repeatForever(sequece2))
    }
    
    func invalidateSpawnSpecial(){
        self.removeAction(forKey: "specialPower")
        self.run(SKAction.sequence([SKAction.wait(forDuration: 9)])) {
            self.spawnSpecialPower()
        }
        
    }
    func pauseGame(){
        self.isPaused = true
//        gameLayer.isPaused = true
//         
//          gameLayer.physicsWorld.speed = 0
//          gameLayer.speed = 0.0

    }
    
    func resumeGame(){
        self.isPaused = false
    }
    
    func saveTheBestScore(score: Int){
       
        if UserDefaults.standard.integer(forKey: "bestScore") < score{
            UserDefaults.standard.set(score, forKey: "bestScore")
        }
        
        
    }
    
    func continueGameAfterDie(){
        
            for node in self.children{
                if node is Enemy{
                    if (character.position.x - abs(node.position.x) ) > -150 || (character.position.y - abs(node.position.y) ) > -150 {
                        node.removeFromParent()
                    }
                }
            }
        self.isPaused = false
        self.parent!.isPaused = false
        self.isAdstoLiveUsed = true
    }
}
