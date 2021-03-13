//
//  Colors.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 15/02/21.
//

import Foundation
import UIKit

extension UIColor {
    static var textfieldBorder: UIColor {
        return UIColor(named: "textfieldBorder") ?? UIColor.gray
    }
    
    static var textfieldBackground: UIColor {
        return UIColor(named: "textfieldBackground") ?? UIColor.systemBackground
    }
    
    static var sliderColor: UIColor {
        return UIColor(named: "appPrimary") ?? UIColor.systemBackground
    }
    
    static var buttonColor: UIColor {
        return UIColor(named: "homeButton") ?? UIColor.systemBlue
    }
}
