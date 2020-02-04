//
//  InitialScene.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 28/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class InitialScene: SKScene{


let screenSize = UIScreen.main.bounds.size
let madeBy = SKLabelNode(text: "MADE BY")
let terraquios = SKLabelNode(text: "TERRAQUIOS")

override func didMove(to view: SKView) {
    self.backgroundColor = .black
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    madeBy.color = .white
    madeBy.fontSize = 80
    madeBy.position = CGPoint(x: -50, y: screenSize.height * 1.5)
    self.addChild(madeBy)
    
    terraquios.fontColor = .blue
    terraquios.colorBlendFactor = 1.0
    terraquios.fontSize = 60
    terraquios.position = CGPoint(x: screenSize.width * 1.5, y: 0)
    self.addChild(terraquios)
    
    animationInitial()
}




func animationInitial(){
    
    let action1 = SKAction.run {
        self.madeBy.run(SKAction.move(to: CGPoint(x: -50, y: 20), duration: 1.0))
    }
    
    let action2 = SKAction.run {
        self.terraquios.run(SKAction.move(to: CGPoint(x: 0, y: -30), duration: 1.0))
    }
    
    let action3 = SKAction.run {
        let scene = HomeMenuScene(size: CGSize(width: 750, height: 1334))
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1.5))
    }
    
    self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), action1,action2,SKAction.wait(forDuration: 2.5),action3]))
           
}


}
