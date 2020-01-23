//
//  Utils.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 21/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import UIKit

struct PhysicsCategory{
    static let none        : UInt32  = 0
    static let projectil   : UInt32  = 1
    static let enemies     : UInt32  = 2
    static let character   : UInt32  = 4
    static let collectible  : UInt32  = 6
}


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
