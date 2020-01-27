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
    var scoreControl = 18
    let score = SKLabelNode(text: "0")
    var scoreInt = 0 {
        didSet{
            if scoreInt == scoreControl{
                delegate?.updateDifficult()
                scoreControl += 18
            }
        }
    }
    
    //pause Menu
    let shadowNode = SKShapeNode(rect: CGRect(x: -0.5, y: -0.5, width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height*2))
    let playButton = SKSpriteNode(imageNamed: "PlayButton")
    let pauseButton = SKSpriteNode(imageNamed: "pauseButton")
    let pauseLabel = SKLabelNode(text: "pause")
    
    //Special nodes
   let progressBar = ProgressBar(textureBackground: "bgprogress", textureBar: "bar")
    
    
    override init() {
        super.init()
        setupColorsMenu()
        
        //score
        self.score.color = .black
        self.score.fontSize = 60
        self.score.colorBlendFactor = 1.0
        self.score.position = CGPoint(x: 0, y: screenSize.height * 1.2)
        self.addChild(score)
        
        //pause nodes
        pauseButton.position = CGPoint(x:  -250 , y: screenSize.height * 1.25)
        pauseButton.name = "pauseButton"
        pauseButton.zPosition = 2
        self.addChild(pauseButton)
        
        shadowNode.fillColor = .black
        shadowNode.alpha = 0.6
        shadowNode.position = CGPoint(x: -screenSize.width, y: 0 + -screenSize.height/2 * 0.8)
        shadowNode.isHidden = true
        shadowNode.zPosition = 3
        self.addChild(shadowNode)
        
        playButton.position = CGPoint(x: 0, y: 200)
        playButton.name = "pauseButton"
        playButton.isHidden = true
        playButton.zPosition = 4
        self.addChild(playButton)
        
        pauseLabel.position = CGPoint(x:  0 , y: screenSize.height * 0.8)
        pauseLabel.fontColor = .white
        pauseLabel.fontSize = 80
        pauseLabel.isHidden = true
        pauseLabel.zPosition = 3
        self.addChild(pauseLabel)
        
        
        //special
        progressBar.position = CGPoint(x: 250, y: screenSize.height * 0.7)
        progressBar.zRotation = CGFloat(90).degreesToradius()
        progressBar.fullProgress = {
            self.delegate?.specialPower()
        }
        self.addChild(progressBar)
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
    
    private func setupPauseMenu(){
        
        shadowNode.isHidden = false
        playButton.isHidden = false
        pauseButton.isHidden = true
        pauseLabel.isHidden = false
    }
    
    private func unsetupPauseMenu(){
        shadowNode.isHidden = true
        playButton.isHidden = true
        pauseButton.isHidden = false
        pauseLabel.isHidden = true
    }
    
    func updateScore(){
        self.scoreInt += 1
        self.score.text = "\(scoreInt)"
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
            
            if pauseButton.contains(location){
                self.setupPauseMenu()
                self.delegate?.pauseGame()
            }
            
            if playButton.contains(location){
                self.unsetupPauseMenu()
                self.delegate?.resumeGame()
            }
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




protocol HudDelegate{
    func menuColors(color: UIColor)
    func updateDifficult()
    func pauseGame()
    func resumeGame()
    func specialPower()
}
