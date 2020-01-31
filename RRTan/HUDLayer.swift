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
    
    
    //end game menu
    let playAgain = SKSpriteNode(imageNamed: "PlayButton")
    let bestScoreLabel = SKLabelNode(text: "Best Score")
    let bestScoreIntLabel = SKLabelNode(text: "0")
    let scoreLabel = SKLabelNode(text: "Score")
    let scoreIntLabel = SKLabelNode(text: "0")
    let gameCenterButton = SKSpriteNode(imageNamed: "gameCenter")
    
    //continue game Menu
    let endGameButton = SKSpriteNode(imageNamed: "endGame")
    let continueGameButton  = SKSpriteNode(imageNamed: "continueAdverting")
    let continueLabel = SKLabelNode(text: "CONTINUE?")
    
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
        shadowNode.alpha = 1.0
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
        
        endGameButton.position = CGPoint(x: 50, y: 500)
        endGameButton.name = "endGameButton"
        endGameButton.isHidden = true
        endGameButton.zPosition = 4
        self.addChild(endGameButton)
        
        continueGameButton.position = CGPoint(x: -50, y: 500)
        continueGameButton.name = "continueGameButton"
        continueGameButton.isHidden = true
        continueGameButton.zPosition = 4
        continueGameButton.setScale(1.5)
        self.addChild(continueGameButton)
        
        continueLabel.fontColor = .blue
        continueLabel.colorBlendFactor = 1.0
        continueLabel.fontSize = 70
        continueLabel.position = CGPoint(x: 0, y: 560)
        continueLabel.zPosition = 4
        continueLabel.isHidden = true
        self.addChild(continueLabel)
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
        
        //end game menu
        
        playAgain.position = CGPoint(x: 0, y: 250)
        playAgain.name = "playAgain"
        playAgain.isHidden = true
        playAgain.zPosition = 4
        self.addChild(playAgain)
        
        gameCenterButton.position = CGPoint(x: 0, y: 500)
        gameCenterButton.name = "gameCenterButton"
        gameCenterButton.isHidden = true
        gameCenterButton.zPosition = 4
        gameCenterButton.setScale(1.8)
        self.addChild(gameCenterButton)
               
        
        bestScoreLabel.color = .blue
        bestScoreLabel.colorBlendFactor = 1.0
        bestScoreLabel.fontSize = 40
        bestScoreLabel.position = CGPoint(x:  195 , y: screenSize.height * 1.14)
        bestScoreLabel.isHidden = true
        bestScoreLabel.zPosition = 10
        self.addChild(bestScoreLabel)
        bestScoreIntLabel.color = .white
        bestScoreIntLabel.fontSize = 40
        bestScoreIntLabel.position = CGPoint(x:  195 , y: screenSize.height * 1.08)
        bestScoreIntLabel.isHidden = true
        bestScoreIntLabel.zPosition = 10
        self.addChild(bestScoreIntLabel)
        
        scoreLabel.color = .blue
        scoreLabel.colorBlendFactor = 1.0
        scoreLabel.fontSize = 40
        scoreLabel.position = CGPoint(x:  -195 , y: screenSize.height * 1.14)
        scoreLabel.isHidden = true
        scoreLabel.zPosition = 10
        self.addChild(scoreLabel)
        scoreIntLabel.color = .white
        scoreIntLabel.fontSize = 40
        scoreIntLabel.position = CGPoint(x:  -195 , y: screenSize.height * 1.08)
        scoreIntLabel.isHidden = true
        scoreIntLabel.zPosition = 10
        self.addChild(scoreIntLabel)
    }
    func setupEndGameMenu(){
        let action = SKAction.run {
          
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration: 2.5),action]))
        self.shadowNode.isHidden = false
        self.playAgain.isHidden = false
        self.pauseButton.isHidden = true
        self.bestScoreLabel.isHidden = false
        self.bestScoreIntLabel.isHidden = false
        self.bestScoreIntLabel.text = "\(UserDefaults.standard.integer(forKey: "bestScore"))"
        self.scoreLabel.isHidden = false
        self.scoreIntLabel.isHidden = false
        self.scoreIntLabel.text = "\(self.scoreInt)"
        self.endGameButton.isHidden = true
        self.continueGameButton.isHidden = true
        self.gameCenterButton.isHidden = false
        self.continueLabel.isHidden = true
    }
    
    
    func setupWishContinueMenu(){
       shadowNode.isHidden = false
       endGameButton.isHidden = false
       pauseButton.isHidden = true
       continueGameButton.isHidden = false
       continueLabel.isHidden = false
    }
    
    func showAdvertising(){
        //mostrar a propaganda
        
        delegate?.continueGameAfterDie()
    }
    
    private func setupPauseMenu(){
        
        shadowNode.isHidden = false
        playButton.isHidden = false
        pauseButton.isHidden = true
        pauseLabel.isHidden = false
        gameCenterButton.isHidden = false
    }
    
    private func unsetupPauseMenu(){
        shadowNode.isHidden = true
        playButton.isHidden = true
        pauseButton.isHidden = false
        pauseLabel.isHidden = true
        gameCenterButton.isHidden = true
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
            
            if endGameButton.contains(location){
                self.setupEndGameMenu()
            }
            
            if continueGameButton.contains(location){
                //self.showAdvertising()
                self.delegate?.continueGameAfterDie()
            }
            
            
            if playButton.contains(location){
                self.unsetupPauseMenu()
                self.delegate?.resumeGame()
            }
            
            if playAgain.contains(location){
             self.delegate?.restartGame()
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
    func restartGame()
    func continueGameAfterDie()
}
