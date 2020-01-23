//
//  ItemGameProtocol.swift
//  RRTan
//
//  Created by Rangel Cardoso Dias on 22/01/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit

@objc protocol ItemGame {
    
    var life: Int { get set }
    @objc optional var lifeRange: Int { get set }
    
    
    
}
