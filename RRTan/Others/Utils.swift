//
//  Utils.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import UIKit

//struct PhysicsCategory{
//    static let none        : UInt32  = 0
//    static let projectil   : UInt32  = 1
//    static let enemies     : UInt32  = 2
//    static let character   : UInt32  = 4
//    static let collectible  : UInt32  = 6
//    static let specialPower  : UInt32  = 8
//
//}

struct PhysicsCategory {
    static let None:  UInt32 = 0 // 0
    static let projectil:   UInt32 = 0b1 // 1
    static let enemies: UInt32 = 0b10 // 2
    static let character:   UInt32 = 0b100 // 4
    static let collectible  : UInt32  = 0b1000 // 6
    static let specialPower  : UInt32  = 0b10000 //16
}

//static let None:   UInt32 = 0
//static let Cat:    UInt32 = 0b1 // 1
//static let Block:  UInt32 = 0b10 // 2
//static let Bed:    UInt32 = 0b100 // 4
//static let Edge:   UInt32 = 0b1000 // 8
//static let Label:  UInt32 = 0b10000 // 16
//static let Spring: UInt32 = 0b100000 // 32
//static let Hook:   UInt32 = 0b1000000 // 64



extension CGFloat{
    func degreesToradius() -> CGFloat {
        return self * .pi / 180
    }
    func radiusToDegree() -> CGFloat {
        return self  * 180 / .pi
    }
}

//operações com CGPoint
func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
  }
#endif

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

//shared view Controller
let appIDAdMob = "ca-app-pub-3940256099942544/1712485313"


weak var sharedViewController: GameViewController? = nil



enum AdType {
    case interstitial
    case reward
}
