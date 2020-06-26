//
//  UIToolboxUtils.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
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
