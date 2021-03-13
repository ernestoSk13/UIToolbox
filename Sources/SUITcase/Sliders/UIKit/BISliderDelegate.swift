//
//  BISliderDelegate.swift
//  oralens
//
//  Created by Maximillian Fuller on 11/22/16.
//  Copyright © 2016 Oracle USA, Inc. All rights reserved.
//

import Foundation

@objc
public protocol BISliderDelegate {
    func sliderDidMove(slider: BISlider)
    func sliderDidEndMovement(slider: BISlider)
}
