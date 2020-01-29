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
    
   
    let gameLayer: GameLayer = GameLayer()
    let hudLayer: HUDLayer = HUDLayer()
    let screenSize = UIScreen.main.bounds
    
    var isNodesInContact = true
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = .gray
        self.addChild(gameLayer)
        self.addChild(gameLayer.character.jtButtom)
        self.addChild(gameLayer.character.jtBack)
        
        
        gameLayer.character.jtButtom.position = CGPoint(x: 0, y: -screenSize.height/2 * 0.9)
        gameLayer.character.jtBack.position = CGPoint(x: 0, y: -screenSize.height/2 * 0.9)
        hudLayer.delegate = self
        self.addChild(hudLayer)
        
        hudLayer.position = CGPoint(x: 0, y: -self.size.height/2 * 0.8)
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
    
        gameLayer.touchDown(atPoint: pos)
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        gameLayer.touchMoved(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        gameLayer.touchUp(atPoint: pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self))
            hudLayer.touchesBegan(touches, with: event)
        }
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
        
        for node in gameLayer.children{
            if node.name == "projectil"{
                if node.position.y > screenSize.height || node.position.y < -screenSize.height{
                    node.removeFromParent()
                }
                if node.position.x > screenSize.width || node.position.x < -screenSize.width{
                    node.removeFromParent()
                }
            }
        }
    }
}



//HUD delegate

extension GameScene: HudDelegate{
    
    func continueGameAfterDie() {
        
    }
    
    func pauseGame() {
        gameLayer.pauseGame()
    }
    
    func resumeGame() {
        gameLayer.resumeGame()
    }
    
    
    func updateDifficult() {
        gameLayer.updateGameDifficult()
    }
    
    func menuColors(color: UIColor){
        gameLayer.character.shootColor = color
    }
    
    func specialPower() {
        gameLayer.character.specialPower()
        gameLayer.invalidateSpawnSpecial()
    }
    
    func restartGame() {
         if let scene = SKScene(fileNamed: "GameScene") {
           // Set the scale mode to scale to fit the window
           scene.scaleMode = .aspectFill
           // Present the scene
            self.view?.presentScene(scene)
         }
    }
    
}



//Physics
extension GameScene:SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {

        if contact.bodyA.categoryBitMask == PhysicsCategory.projectil || contact.bodyB.categoryBitMask == PhysicsCategory.projectil || contact.bodyA.categoryBitMask == PhysicsCategory.specialPower || contact.bodyB.categoryBitMask == PhysicsCategory.specialPower{

            if let node = contact.bodyA.node as? Enemy{
            
                if contact.bodyA.node?.name == "specialPower"{
                    let action = SKAction.run {
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                    }
                    node.run(SKAction.repeatForever(SKAction.sequence([action, SKAction.wait(forDuration: 0.1)])), withKey: "killingAction")
                }else if node.color == gameLayer.character.shootColor{
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                }else if node.name == "triangle"{
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                }else{
                    let action = SKAction.run {
                          node.speed = 0.2
                      }
                      let action2 = SKAction.run {
                          node.speed = 1
                      }
                    let sequece = SKAction.sequence([action,SKAction.wait(forDuration: 0.5),action2])
                      node.run(sequece)
                }
            }
            if let node = contact.bodyB.node as? Enemy{
                if contact.bodyA.node?.name == "specialPower"{
                    let action = SKAction.run {
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                    }
                    node.run(SKAction.repeatForever(SKAction.sequence([action, SKAction.wait(forDuration: 0.1)])), withKey: "killingAction")
                }else if node.color == gameLayer.character.shootColor{
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                }else if node.name == "trangle"{
                        node.life -= 1
                        node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                }else{
                    let action = SKAction.run {
                        node.speed = 0.2
                    }
                    let action2 = SKAction.run {
                        node.speed = 1
                    }
                    let sequece = SKAction.sequence([action,SKAction.wait(forDuration: 0.7),action2])
                    node.run(sequece)
                }
            }
        }

         if contact.bodyA.categoryBitMask == PhysicsCategory.character || contact.bodyB.categoryBitMask == PhysicsCategory.character{
            self.isPaused = true
            let node  = SKLabelNode(text: "VC MORREU")
            node.fontSize = 80
            node.fontColor = .green
            node.position  = CGPoint(x: 0, y: 0)
            self.addChild(node)
            self.gameLayer.saveTheBestScore(score: self.hudLayer.scoreInt)
            self.hudLayer.setupWishContinueMenu()
         }

         if contact.bodyA.categoryBitMask == PhysicsCategory.collectible || contact.bodyB.categoryBitMask == PhysicsCategory.collectible{
            
            
            if contact.bodyA.node?.name == "specialPower"{
                if let node = contact.bodyB.node as? Collectable{
                    let action = SKAction.run {
                       node.life -= 1
                       node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                     }
                node.run(SKAction.repeatForever(SKAction.sequence([action, SKAction.wait(forDuration: 0.1)])), withKey: "killingAction")
                }
            }else if contact.bodyB.node?.name == "specialPower"{
                if let node = contact.bodyA.node as? Collectable{
                    let action = SKAction.run {
                           node.life -= 1
                           node.life == 0 ? self.hudLayer.updateScore() : print("vamos arrumar isso rangel")
                         }
                node.run(SKAction.repeatForever(SKAction.sequence([action, SKAction.wait(forDuration: 0.1)])), withKey: "killingAction")
                }
            } else if let node = contact.bodyA.node as? Collectable, node.name == "levelUP"{
                node.life -= 1
                gameLayer.character.shootingsPerSecond -= node.life == 0 ?  0.12 : 0
            }else if let node = contact.bodyA.node as? Collectable, node.name == "specialPower"{
               node.life -= 1
               if node.life == 0 { hudLayer.progressBar.progress += 0.35 }
            }
            if let node = contact.bodyB.node as? Collectable, node.name == "levelUP"{
                node.life -= 1
                gameLayer.character.shootingsPerSecond -= node.life == 0 ?  0.12 : 0
            }else if let node = contact.bodyA.node as? Collectable, node.name == "specialPower"{
                 node.life -= 1
                if node.life == 0 { hudLayer.progressBar.progress += 0.35 }
            }
         }


    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        contact.bodyA.node?.removeAction(forKey: "killingAction")
        contact.bodyB.node?.removeAction(forKey: "killingAction")
    }
}

//extension GameScene:SKPhysicsContactDelegate{
//    func didBegin(_ contact: SKPhysicsContact) {
//
//        let colision = contact.bodyA.categoryBitMask | contact.bodyB.co
//
//
//    }
//}
