//
//  ADViewController.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 29/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import GoogleMobileAds

class ADViewController: UIViewController {
    
    
    
    var gaReward: GADRewardedAd? = nil
    var gameScene: GameScene? = nil
    
    init() {
        super.init(nibName: "ADViewController", bundle: nil)
         gaReward = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
       
    
    
    func createAndLoadRewardedAd() -> GADRewardedAd? {
      gaReward = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        
      gaReward?.load(GADRequest()) { error in
        if let error = error {
          print("Loading failed: \(error)")
        } else {
          print("Loading Succeeded")
        }
      }
      return gaReward
    }
}


extension ADViewController: GADRewardedAdDelegate{
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        gameScene?.restartGame()
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.gaReward = self.createAndLoadRewardedAd()
    }
    
    
}
