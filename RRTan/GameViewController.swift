//
//  GameViewController.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//
// APP ID GOOGLE: ca-app-pub-3897788254968246~3329492229
import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
class GameViewController: UIViewController {

   
    var interstitial: GADInterstitial? = nil
    var timesPlayed = 0
    var scene : GameScene? {
       didSet{
          //Optional: In case you can change scenes - remove view controller from old scen
          //Actually set view controller of any scene it "own"
          scene?.viewController = self
       }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: appIDAdMob)
        interstitial?.delegate = self
        sharedViewController = self
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        if let view = self.view as! SKView? {
            
              
            // Load the SKScene from 'GameScene.sks'
           
//            if let scene = SKScene(fileNamed: "InitialScene") {
                // Set the scale mode to scale to fit the window
            let scene = InitialScene(size: CGSize(width: 750, height: 1334))
            scene.scaleMode = .aspectFill
        
                // Present the scene
            view.presentScene(scene)
//            }
            
            view.ignoresSiblingOrder = true
//            view.showsPhysics = true
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
        
        UserDefaults.standard.register(defaults: ["bestScore" : 0])
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createAndLoadRewardedAd() -> GADRewardedAd? {
       let gaReward = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
         
       gaReward.load(GADRequest()) { error in
         if let error = error {
           print("Loading failed: \(error)")
         } else {
           print("Loading Succeeded")
         }
       }
       return gaReward
     }
    
    
    func createAndLoadInterstitial() -> GADInterstitial {
      let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }
}



//extension GameViewController: GADRewardedAdDelegate{
//    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
//        scene?.restartGame()
//    }
//
//    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
//        self.gaReward = self.createAndLoadRewardedAd()
//    }
//
//
//}

extension GameViewController: GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        scene?.restartGame()
//        scene?.continueGameAfterDie() devo implementar esse metodo
    }
    
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: appIDAdMob)
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
        didFailToLoadWithError error: Error) {
      print("Reward based video ad failed to load.")
    }
    
}


extension GameViewController: GADInterstitialDelegate{
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = createAndLoadInterstitial()
        scene?.restartGame()
    }
    
}
