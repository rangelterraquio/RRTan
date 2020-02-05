//
//  Progressbar.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 23/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class ProgressBar: SKNode {
    
    
    let size = UIScreen.main.bounds
    
    var background: SKSpriteNode!
    var bar: SKSpriteNode!
    var fullProgress: (() -> ())?
    var progress:CGFloat = 0{
        didSet{
            let value = max(min(progress,1.0),0.0)
            if let bar = bar {
            bar.xScale = value
            }
            if progress >= 1 {
                if let function = fullProgress{
                    function()
                }
                progress = 0
                bar.xScale = 0
            }
        }
    }
    
    init(textureBackground: String, textureBar: String){
        super.init()
        background = SKSpriteNode(imageNamed: textureBackground)
        bar = SKSpriteNode(imageNamed: textureBar)
        background.setScale(0.7)
        background.position = CGPoint(x: -25, y: 0)
        bar.setScale(0.4)
        bar.xScale = 0.0
        bar.zPosition = 1.0
        bar.position = CGPoint(x:-size.width/2,y:0)
        bar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.addChild(background)
        self.addChild(bar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
