//
//  LoaderState.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 18/08/20.
//

import SwiftUI

enum LoaderState: CaseIterable {
    case right
    case down
    case left
    case up
    
    var alignment: Alignment {
        .center
    }
    
    var bubbleDimension: CGFloat {
        return 24
    }
    
    var increasingSize: CGFloat {
        return 36
    }
    
    var size1: CGFloat {
        return 6
    }
    
    var size4: CGFloat {
        return 6
    }
    
    var decreasingSize: CGFloat {
        return 12
    }
    
    var previousTransition: (CGFloat, CGFloat, CGFloat, CGFloat) {
        switch self {
        case .right:
            return (-bubbleDimension * 0.5, 0, bubbleDimension, bubbleDimension)
        case .down:
            return (-bubbleDimension * 0.5, -bubbleDimension * 1.5, bubbleDimension, bubbleDimension)
        case .left:
            return (bubbleDimension, -bubbleDimension * 1.5, bubbleDimension, bubbleDimension)
        case .up:
            return (bubbleDimension, 0, bubbleDimension, bubbleDimension)
        }
    }
    
    var postTransition: (CGFloat, CGFloat, CGFloat, CGFloat) {
        switch self {
        case .right:
            return (-bubbleDimension * 0.5, 0, bubbleDimension, bubbleDimension)
        case .down:
            return (-bubbleDimension * 0.5, -bubbleDimension * 1.5, bubbleDimension, bubbleDimension)
        case .left:
            return (bubbleDimension, -bubbleDimension * 1.5, bubbleDimension, bubbleDimension)
        case .up:
            return (bubbleDimension, 0, bubbleDimension, bubbleDimension)
        }
    }
}
