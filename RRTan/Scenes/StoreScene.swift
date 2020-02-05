//
//  StoreScene.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 04/02/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import SpriteKit
import SwiftySKScrollView

class StoreScene: SKScene{
    
    
    
    let characters = [SKSpriteNode(imageNamed: "elephant"),SKSpriteNode(imageNamed: "elephant"),SKSpriteNode(imageNamed: "elephant")]
    
    
    let priceButtons = [SKLabelNode(text: "0.99"),SKLabelNode(text: "0.99"),SKLabelNode(text: "0.99")]
    
    
    var posInicial: CGPoint = .zero
    var posInicialCam: CGPoint = .zero
    var posFinal: CGPoint = .zero
    var cam = SKCameraNode()
    
    
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    var  sprite1Page1: SKSpriteNode!
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.camera = cam
        self.addChild(cam)
        self.backgroundColor = .yellow
        setupItens()
        addChild(moveableNode)
       setupScrollView()
    }
    
    
    
    func setupItens(){
        var position = CGPoint(x: 0, y: 0)
        
        for i in 0...characters.count-1{
            characters[i].position = position
//            self.addChild(characters[i])
            priceButtons[i].position = CGPoint(x: position.x, y: size.height*0.3)
            priceButtons[i].fontSize = 40
            priceButtons[i].fontColor = .blue
            priceButtons[i].colorBlendFactor = 1.0
//            self.addChild(priceButtons[i])
            
            position.x += self.size.width
        }
        
    }
    
    
    func setupScrollView(){
        
        //scroll view
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .horizontal)
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width * 3, height: scrollView!.frame.height) // * 3 makes it three times as wide
        view?.addSubview(scrollView!)
        scrollView?.setContentOffset(CGPoint(x: 0 + scrollView!.frame.width * 2, y: 0), animated: true)
        
        //adiciono um sprite para facilitar o positionamento de outros node em cada página
        guard let scrollView = scrollView else { return } // unwrap  optional

        let page1ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
        page1ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width * 2), y: frame.midY)
        moveableNode.addChild(page1ScrollView)
                
        let page2ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
        page2ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width), y: frame.midY)
        moveableNode.addChild(page2ScrollView)
                
        let page3ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
        page3ScrollView.zPosition = -1
        page3ScrollView.position = CGPoint(x: frame.midX, y: frame.midY)
        moveableNode.addChild(page3ScrollView)
        
        
        //aqui adiciono os sprites que eu quero
        /// Test sprites page 1
       /// Test sprites page 1
       sprite1Page1 = SKSpriteNode(imageNamed: "elephant")
       sprite1Page1.position = CGPoint(x: 0, y: 0)
       page1ScrollView.addChild(sprite1Page1)
       priceButtons[0].position = CGPoint(x: 0, y: size.height*0.3)
       priceButtons[0].fontSize = 40
       priceButtons[0].fontColor = .blue
       priceButtons[0].colorBlendFactor = 1.0
       page1ScrollView.addChild( priceButtons[0])
               
       /// Test sprites page 2
       let sprite1Page2 = SKSpriteNode(imageNamed: "elephant")
       sprite1Page2.position = CGPoint(x: 0, y: 0)
       page2ScrollView.addChild(sprite1Page2)
       priceButtons[1].position = CGPoint(x: 0, y: size.height*0.3)
       priceButtons[1].fontSize = 40
       priceButtons[1].fontColor = .blue
       priceButtons[1].colorBlendFactor = 1.0
       page2ScrollView.addChild( priceButtons[1])
        
               
       /// Test sprites page 3
       let sprite1Page3 = SKSpriteNode(imageNamed: "elephant")
       sprite1Page3.position = CGPoint(x: 0, y: 0)
       page3ScrollView.addChild(sprite1Page3)
       priceButtons[2].position = CGPoint(x: 0, y: size.height*0.3)
       priceButtons[2].fontSize = 40
       priceButtons[2].fontColor = .blue
       priceButtons[2].colorBlendFactor = 1.0
       page3ScrollView.addChild( priceButtons[2])
       
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        self.posInicialCam = self.cam.position
        self.posInicial = location!
        
        cam.position =  sprite1Page1.position
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
     
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
            
        self.posFinal = location!
           cam.position.x += location!.x - posInicial.x
       // moveCamera(deslocamento: cam.position.x - posInicialCam.x)
        
    }
    
    
    func moveCamera(deslocamento: CGFloat){
        
      
        var position = cam.position
        if deslocamento > size.width/2 {
            position.x = size.width - posInicialCam.x
        }else{
            position.x = posInicialCam.x
        }
        
//        if deslocamento > 0 {
//            position.x += size.width
//        }else{
//            position.x -= size.width
//        }
//
        let action = SKAction.move(to: position , duration: 0.5)
        cam.run(action)
        
    }
    
    
}
