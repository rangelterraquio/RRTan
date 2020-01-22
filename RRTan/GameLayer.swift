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
    
    override init() {
        super.init()
        character.position = CGPoint.zero
        character.shooting(layer: self)
        self.addChild(character)
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
}
