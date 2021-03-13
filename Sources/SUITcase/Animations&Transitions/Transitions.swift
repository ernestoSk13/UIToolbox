//
//  Animations.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static func offsetFrom(x: CGFloat, y: CGFloat, combinedWith t: AnyTransition) -> AnyTransition {
        return AnyTransition.offset(x: x, y: y).combined(with: t)
    }
}
