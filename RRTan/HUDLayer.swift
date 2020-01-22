//
//  HUDLayer.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

class HUDLayer: SKNode {
    
    let screenSize = UIScreen.main.bounds
    
    
    var delegate: HudDelegate? = nil
    //colorsMenu
    var redButton: SKShapeNode! = nil
    var greenButton: SKShapeNode! = nil
    var blueButton: SKShapeNode! = nil
    
    //score
    let score = SKLabelNode(text: "0")
    var scoreInt = 0
    override init() {
        super.init()
        setupColorsMenu()
        
        self.score.color = .black
        self.score.fontSize = 60
        self.score.colorBlendFactor = 1.0
        self.score.position = CGPoint(x: 0, y: screenSize.height * 1.2)
        self.addChild(score)
        
    }
    
    private func setupColorsMenu(){
        
        redButton = SKShapeNode(rectOf: CGSize(width: screenSize.width/5, height: 85))
        greenButton = SKShapeNode(rectOf: CGSize(width: screenSize.width/5, height: 85))
        blueButton = SKShapeNode(rectOf: CGSize(width: screenSize.width/5, height: 85))
        
        blueButton.position = CGPoint(x: 0, y: 0)
        blueButton.fillColor = .blue
        blueButton.name = "blueButton"
        self.addChild(blueButton)
        
        greenButton.position = CGPoint(x: blueButton.position.x + greenButton.frame.width, y: 0)
        greenButton.fillColor = .green
        greenButton.name = "greenButton"
        self.addChild(greenButton)
        
        redButton.position = CGPoint(x: blueButton.position.x - greenButton.frame.width, y: 0)
        redButton.fillColor = .red
        redButton.name = "redButton"
        self.addChild(redButton)
        
     
    }
    
    func updateScore(){
        self.score.text = "\(scoreInt+=1)"
    }
    
    
    func touchDown(atPoint pos : CGPoint) -> UIColor? {
        
        return nil
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // for t in touches { self.touchDown(toPoint: t.location(in: self)) }
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            
            if redButton.contains(location){   delegate?.menuColors(color: .red)}
            if greenButton.contains(location){ delegate?.menuColors(color: .green)}
            if blueButton.contains(location){  delegate?.menuColors(color: .blue)}
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




protocol HudDelegate{
    func menuColors(color: UIColor)
}
