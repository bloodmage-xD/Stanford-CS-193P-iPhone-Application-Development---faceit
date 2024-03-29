//
//  File.swift
//  faceit
//
//  Created by pokemon on 6/2/17.
//  Copyright © 2017 pokemon. All rights reserved.
//

import Foundation

struct FacialExpression{
    enum Eyes: Int{
        case open
        case closed
        case squint
    }
    enum Mouth : Int{
        case frown
        case smirk
        case neutral
        case smile
        case grin
    
    var sadder: Mouth {
        return Mouth(rawValue: rawValue - 1) ?? .frown
    }
    var happier : Mouth{
        return Mouth(rawValue : rawValue + 1) ?? .smile
    }
}
    var sadder : FacialExpression{
        return FacialExpression(eyes: self.eyes, mouth : self.mouth.sadder)
    }
    var happier : FacialExpression{
        return FacialExpression(eyes: self.eyes, mouth : self.mouth.happier)
    }
    var eyes: Eyes
    var mouth : Mouth

}
