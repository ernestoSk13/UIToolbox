//
//  BISlider.swift
//  RangeSlider
//
//  Created by Maximillian Fuller on 8/19/16.
//  Copyright © 2016 Maximillian Fuller. All rights reserved.
//

import Foundation
import UIKit

public class BISlider: UIControl {

    //public properties
    public var buttonRadius: CGFloat = 15.0 {
        didSet {
            configureSubviews()
            setNeedsLayout()
            layoutIfNeeded() //will call layoutSubviews
        }
    }
    public var trackThickness: CGFloat = 2.0 {
        didSet {
            configureSubviews()
            setNeedsLayout()
            layoutIfNeeded() //will call layoutSubviews
        }
    }
    public var insideTrackColor = UIColor(red: 81.0/255,
                                          green: 192.9/255,
                                          blue: 134.0/255,
                                          alpha: 1.0) { //(left color for simple slider)
        didSet {
            configureSubviews()
        }
    }
    public var outsideTrackColor = UIColor(red: 220.0/255,
                                           green: 220.0/255,
                                           blue: 220.0/255,
                                           alpha: 1.0) {
        didSet {
            configureSubviews()
        }
    }
    public var buttonColor = UIColor.white {
        didSet {
            configureSubviews()
        }
    }
    public var vertical: Bool = false {
        didSet {
            configureSubviews()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    public weak var delegate: BISliderDelegate?

    //readonly properties
    private(set) var maximumValue = 100.0
    private(set) var minimumValue = 0.0

    //computed properties
    var buttonContainerWidth: CGFloat {
        return 2*buttonRadius*(1.0+paddingToRadiusRatio)
    }
    var frameLength: CGFloat { //width when horizontal
        return vertical ? frame.height : frame.width
    }
    var frameGirth: CGFloat { //height when horizontal
        return vertical ? frame.width : frame.height
    }

    /** determines how much padding there is around each button (for touch events) */
    var paddingToRadiusRatio: CGFloat = 0.6

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor.clear
    }

    /** sets max and min */
    public func setRange(minimum: Double, maximum: Double) {
        minimumValue = (minimum == 0) ? 1 : minimum
        maximumValue = maximum
        if maximumValue < minimumValue {
            minimumValue = maximum
            maximumValue = minimum
        }
        if maximum == minimum {
            //not sure if this is the correct default behavior,
            //but when maximum is equal to the minimum, the slider is in an invalid state
            maximumValue = minimum + 1.0
        }
        boundsWereChanged()
        setNeedsLayout()
        layoutIfNeeded()
    }

    /** subclasses can configure their buttons using this method */
    func configureButton(button: UIView) {
        let buttonThumbnail = UIView()
        buttonThumbnail.layer.cornerRadius = buttonRadius
        buttonThumbnail.layer.shadowColor = UIColor.black.cgColor
        buttonThumbnail.layer.shadowRadius = 3.0
        buttonThumbnail.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonThumbnail.layer.shadowOpacity = 0.3
        buttonThumbnail.backgroundColor = buttonColor
        buttonThumbnail.frame = CGRect(x: buttonRadius*paddingToRadiusRatio,
                                       y: buttonRadius*paddingToRadiusRatio,
                                       width: 2*buttonRadius,
                                       height: 2*buttonRadius)
        button.subviews.forEach({ $0.removeFromSuperview() })
        button.addSubview(buttonThumbnail)
        button.backgroundColor = UIColor.clear
    }
    /** To be overridden by subclasses. Called whenever a ui property is changed */
    func configureSubviews() {
    }

    /** To be overridden by subclasses. Called whenever the maximimum or minimum value change */
    func boundsWereChanged() {
    }

    /** Uses the x or y component from loc (depending on the orientation of the slider)
    to calculate the correct value */
    func getValueFromLocation(loc: CGPoint) -> Double {
        let locComponent = vertical ? frame.height - loc.y : loc.x
        let frameLength = vertical ? frame.height : frame.width
        let locComponentDifference = Double((locComponent-buttonRadius) / (frameLength - buttonRadius))
        return Double(locComponentDifference * (maximumValue - minimumValue) + minimumValue)
    }

    /** allows this view to handle touch events, instead of subviews */
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: event) {
            return nil
        }
            return self
    }
}

/** rotates rect counter-clockwise. Used to reposition ui elements for vertical view */
extension CGRect {
    public func rotateRectWithinFrame(frame: CGRect) -> CGRect {
        return CGRect(x: minY, y: frame.height-minX - width, width: height, height: width)
    }
}
