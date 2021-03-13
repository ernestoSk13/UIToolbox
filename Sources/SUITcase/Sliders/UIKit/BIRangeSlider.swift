//
//  BIRangeSlider.swift
//  RangeSlider
//
//  CreRangeated by Maximillian Fuller on 8/18/16.
//  Copyright © 2016 Maximillian Fuller. All rights reserved.
//

import Foundation
import UIKit

public class BIRangeSlider: BISlider {

    //public properties
    public var lowerValue = 40.0 {
        didSet {
            lowerValue = min(max(lowerValue, minimumValue), maximumValue)
            if lowerValue > upperValue {
                upperValue = lowerValue
            }
            setNeedsLayout()
            layoutIfNeeded() //will call layoutSubviews
        }
    }
    public var upperValue = 60.0 {
        didSet {
            upperValue = min(max(upperValue, minimumValue), maximumValue)
            if upperValue < lowerValue {
                lowerValue = upperValue
            }
            setNeedsLayout()
            layoutIfNeeded() //will call layoutSubviews
        }
    }

    //ui components
    private let track1 = UIView()
    private let track2 = UIView()
    private let track3 = UIView() //track divided into 3 views
    private let foregroundButton = UIView()
    private let backgroundButton = UIView()

    //internal state
    private var foregroundButtonIsDragging = false
    private var rangeIsDragging = false
    private var backgroundButtonIsDragging = false
    private var prevLoc = CGPoint()
    //when the foreground button has a lower value than the background button
    private var foregroundLowerThanBackgroundButton = true

    /// Initialize a BIRangeSlider with a CGRect
    ///
    /// - Parameter frame: slider frame
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureSubviews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        configureSubviews()
    }

    /// Adds sub views to Slider
    private func addSubviews() {
        addSubview(track1)
        addSubview(track2)
        addSubview(track3)
        addSubview(foregroundButton)
        addSubview(backgroundButton)
    }

    /// Subview default configuration
    override func configureSubviews() {
        //button config
        configureButton(button: foregroundButton)
        configureButton(button: backgroundButton)

        //track config
        track1.layer.cornerRadius = trackThickness/2.0
        track2.layer.cornerRadius = trackThickness/2.0
        track3.layer.cornerRadius = trackThickness/2.0
        track1.backgroundColor = outsideTrackColor
        track2.backgroundColor = insideTrackColor
        track3.backgroundColor = outsideTrackColor

    }
    /// Updates lower and upper values when max and min change
    override func boundsWereChanged() {
        //order is important here
        if upperValue < minimumValue {
            upperValue = minimumValue
        }
        if lowerValue < minimumValue {
            lowerValue = minimumValue
        }
        if lowerValue > maximumValue {
            lowerValue = maximumValue
        }
        if upperValue > maximumValue {
            upperValue = maximumValue
        }
    }

    override public func layoutSubviews() {

        let lowerDifference = CGFloat((lowerValue-minimumValue)/(maximumValue-minimumValue))
        let lowerButtonOffset = CGFloat(lowerDifference * (frameLength - 2*buttonRadius))
        let upperDifference = CGFloat((upperValue-minimumValue)/(maximumValue-minimumValue))
        let upperButtonOffset = CGFloat(upperDifference * (frameLength - 2*buttonRadius))

        let foregroundButtonOffset = CGFloat(foregroundLowerThanBackgroundButton ?
            lowerButtonOffset : upperButtonOffset)
        let backgroundButtonOffset = CGFloat(foregroundLowerThanBackgroundButton ?
            upperButtonOffset : lowerButtonOffset)
        let trackHeight = frameGirth/2.0 - CGFloat(trackThickness/2.0)
        let buttonHeight = frameGirth/2.0 - buttonContainerWidth/2.0

        track1.frame = CGRect(x: 0, y: trackHeight, width: lowerButtonOffset, height: trackThickness)
        track2.frame = CGRect(x: lowerButtonOffset,
                              y: trackHeight,
                              width: upperButtonOffset - lowerButtonOffset,
                              height: trackThickness)
        track3.frame = CGRect(x: upperButtonOffset,
                              y: trackHeight,
                              width: frameLength - upperButtonOffset,
                              height: trackThickness)
        foregroundButton.frame = CGRect(x: foregroundButtonOffset - buttonRadius*paddingToRadiusRatio,
                                        y: buttonHeight,
                                        width: buttonContainerWidth,
                                        height: buttonContainerWidth)
        
        backgroundButton.frame = CGRect(x: backgroundButtonOffset - buttonRadius*paddingToRadiusRatio,
                                        y: buttonHeight,
                                        width: buttonContainerWidth,
                                        height: buttonContainerWidth)
        if vertical {
            track1.frame = track1.frame.rotateRectWithinFrame(frame: frame)
            track2.frame = track2.frame.rotateRectWithinFrame(frame: frame)
            track3.frame = track3.frame.rotateRectWithinFrame(frame: frame)
            foregroundButton.frame = foregroundButton.frame.rotateRectWithinFrame(frame: frame)
            backgroundButton.frame = backgroundButton.frame.rotateRectWithinFrame(frame: frame)
        }

    }

    /// Tracking method for Slider
    ///
    /// - Parameters:
    ///   - touch: UITouch instance
    ///   - event: Event that started touch
    /// - Returns: returns true if touches began
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let loc = touch.location(in: self)
        let locValue = getValueFromLocation(loc: loc)
        prevLoc = loc
        //regular touching and dragging the buttons
        if foregroundButton.frame.contains(loc) {
            foregroundButtonIsDragging = true
            if foregroundLowerThanBackgroundButton {
                lowerValue = locValue
            } else {
                upperValue = locValue
            }
            return true
        }
        if backgroundButton.frame.contains(loc) {
            backgroundButtonIsDragging = true
            if foregroundLowerThanBackgroundButton {
                upperValue = locValue
            } else {
                lowerValue = locValue
            }
            return true
        }
        //if user drags in the touch area that borders the slider (that's not the buttons), we do one of two things:
        var touchArea = CGRect(x: 0,
                               y: frameGirth/2 - buttonContainerWidth/2.0,
                               width: frameLength,
                               height: buttonContainerWidth)
        if vertical {
            touchArea = touchArea.rotateRectWithinFrame(frame: frame)
        }
        if touchArea.contains(loc) {
            //1. touching left or right of range snaps closest button to that location
            if locValue < lowerValue {
                lowerValue = locValue
                if foregroundLowerThanBackgroundButton {
                    foregroundButtonIsDragging = true
                } else {
                    backgroundButtonIsDragging = true
                }
            } else if locValue > upperValue {
                upperValue = locValue
                if !foregroundLowerThanBackgroundButton {
                    foregroundButtonIsDragging = true
                } else {
                    backgroundButtonIsDragging = true
                }
            } else {
                //2. touching middle of range drags whole range while keeping width of range constant
                rangeIsDragging = true
            }
            return true
        }

        return false
    }

    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let loc = touch.location(in: self)
        let valueDelta = getValueFromLocation(loc: loc) - getValueFromLocation(loc: prevLoc)
        prevLoc = loc
        if rangeIsDragging {
            //drag range
            let clippedValueDelta = min(max(valueDelta,
                                            minimumValue - lowerValue),
                                        maximumValue - upperValue) //prohibits dragging too far
            lowerValue += clippedValueDelta
            upperValue += clippedValueDelta
        } else {
            //drag each button
            if (foregroundButtonIsDragging && foregroundLowerThanBackgroundButton) ||
                (backgroundButtonIsDragging && !foregroundLowerThanBackgroundButton) {
                if lowerValue + valueDelta > upperValue { //the buttons pass each other
                    lowerValue = upperValue
                    upperValue = lowerValue + valueDelta
                    foregroundLowerThanBackgroundButton = !foregroundLowerThanBackgroundButton
                } else {
                    lowerValue += valueDelta
                }
            } else {
                if upperValue + valueDelta < lowerValue { //the buttons pass each other
                    upperValue = lowerValue
                    lowerValue = upperValue + valueDelta
                    foregroundLowerThanBackgroundButton = !foregroundLowerThanBackgroundButton
                } else {
                    upperValue += valueDelta
                }
            }
        }
        delegate?.sliderDidMove(slider: self)

        return true
    }

    /// Override method that gets called when touches ended
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        foregroundButtonIsDragging = false
        backgroundButtonIsDragging = false
        rangeIsDragging = false
        delegate?.sliderDidEndMovement(slider: self)
    }

    /// Overrude method that gets called when tracking gets cancelled
    override public func cancelTracking(with event: UIEvent?) {
        foregroundButtonIsDragging = false
        backgroundButtonIsDragging = false
        rangeIsDragging = false
        delegate?.sliderDidEndMovement(slider: self)
    }
}
