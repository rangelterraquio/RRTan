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
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .gray
        self.addChild(gameLayer)
        
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
    }
}



//HUD delegate

extension GameScene: HudDelegate{
    func menuColors(color: UIColor){
        gameLayer.character.shootColor = color
    }
    
    
}
