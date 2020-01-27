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
    
    var timer: Timer!
    var timerSpecialPower: Timer!
    var timerSpawn: TimeInterval = 0
    var currentTime: TimeInterval = 0
    
    //com essas 2 properties eu verifico se tinha um coletável na hora q o jogador pressionou pause
    var isCollectibleActive = false
    var isSpecialPowerActive = false
    
    override init() {
        super.init()
        character.position = CGPoint.zero
        character.shooting(layer: self)
        self.addChild(character)
        spawnEnemies()
        spawnUpLevel(timeInterval: 21)
        spawnSpecialPower(timeInterval: TimeInterval.random(in: 20...35))
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
    
    
    func spawnUpLevel(timeInterval: TimeInterval){
        var node: Collectable!
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (time) in
            node = Collectable(textureName: "levelUP")
            self.isCollectibleActive = true
            let xPos = CGFloat.random(in: -self.screenSize.width*0.8...self.screenSize.width*0.8)
            let yPos = CGFloat.random(in: -self.screenSize.height*0.8...self.screenSize.height*0.8)
            node.position = CGPoint(x: xPos, y: yPos)
            node.life = Int(arc4random()) % node.lifeRange
            node.name = "levelUP"
            self.addChild(node)
            
            let timer = Timer.scheduledTimer(withTimeInterval: 13, repeats: false) { (timer) in
                node.removeFromParent()
                timer.invalidate()
                self.isCollectibleActive = false
                self.timerSpawn = 20
            }
            
        }
    
    }
    
    func spawnSpecialPower(timeInterval: TimeInterval){
        var node: Collectable!
        timerSpecialPower = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (time) in
            node = Collectable(textureName: "specialPower")
            self.isSpecialPowerActive = true
            let xPos = CGFloat.random(in: -self.screenSize.width*0.8...self.screenSize.width*0.8)
            let yPos = CGFloat.random(in: -self.screenSize.height*0.8...self.screenSize.height*0.8)
            node.position = CGPoint(x: xPos, y: yPos)
            node.life = Int(arc4random()) % node.lifeRange
            node.name = "specialPower"
            self.addChild(node)
            
            let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
                node.removeFromParent()
                timer.invalidate()
                self.isSpecialPowerActive = false
            }
            
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
        self.timerSpecialPower.invalidate()
        self.timerSpecialPower = nil
        
        self.run(SKAction.wait(forDuration: 10)) {
            self.spawnSpecialPower(timeInterval: TimeInterval.random(in: 21...35))
        }
    }
    func pauseGame(){
        self.isPaused = true
        self.timer.invalidate()
        self.timer = nil
        self.timerSpecialPower.invalidate()
        self.timerSpecialPower = nil
    }
    
    func resumeGame(){
        self.isPaused = false
        if self.isCollectibleActive {
            spawnUpLevel(timeInterval: 1)
        }else{
            spawnUpLevel(timeInterval: 21)
        }
        if self.isSpecialPowerActive{
            spawnSpecialPower(timeInterval: 1)
        }else{
            spawnSpecialPower(timeInterval: TimeInterval.random(in: 21...40))
        }
    }
    
}
