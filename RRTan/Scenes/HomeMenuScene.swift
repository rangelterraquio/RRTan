//
//  HomeMenuScene.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 28/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit


class HomeMenuScene: SKScene{
    
    
    
    let titleLabel = SKLabelNode(text: "Dale War")
    let playButton = SKSpriteNode(imageNamed: "PlayButton")
    let storeButton = SKSpriteNode(imageNamed: "cart")
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = .black
        titleLabel.fontColor = .blue
        titleLabel.colorBlendFactor = 1.0
        titleLabel.fontSize = 80
        titleLabel.position = CGPoint(x: 0, y: 60)
        self.addChild(titleLabel)
        
        
        playButton.position = CGPoint(x: 70, y: -60)
        self.addChild(playButton)
        
        
        storeButton.position = CGPoint(x: -70, y: -60)
        self.addChild(storeButton)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        
        if playButton.contains(location){
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.crossFade(withDuration: 1.5))
        }
        
        if storeButton.contains(location){
            let scene = StoreScene(size: CGSize(width: 750, height: 1334))
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.8))
        }
    }
    
    
    
}
