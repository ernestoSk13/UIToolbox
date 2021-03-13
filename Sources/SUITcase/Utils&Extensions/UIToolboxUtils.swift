//
//  UIToolboxUtils.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import Foundation
#if targetEnvironment(macCatalyst) || os(iOS)
import UIKit

public extension UIDevice {
    static var currentDeviceWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static var currentDeviceHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isLandscape: Bool {
        return UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

public enum ComponentTypes: String, CaseIterable {
    case button = "Buttons"
    case textfield = "Textfields"
    case textView = "TextViews"
    case searchBar = "Search Bars"
    case spark = "Spark Views"
    case filters = "Filters"
    case webView = "WebView"
    case progressBar = "Progress Bars"
    case collectionView = "Collections/Grids"
    case bottomSheet = "Bottom Sheets"
    case activityIndicators = "Activity Indicators"
    case tabBar = "Tab Bars"
    case animations = "Animations"
    case progressRings = "Progress Rings"
    case sliders = "Sliders"
}

let listSampleData = ["Red", "Yellow", "Green", "Black", "White", "Orange", "Blue", "Grey"]
#endif

extension Double {
    var roundedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))!
    }
    
    func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor) / divisor
    }
    
    func format(formatToApply: String) -> String {
        return String(format: "%\(formatToApply)f", self)
    }
    
}
