//
//  Double+extension.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 05/01/21.
//

import Foundation

public extension Double {
    /// returns a String value of a Double that has only one decimal.
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    /// Converts a range to an x coordinate
    /// - Parameters:
    ///   - fromRange: a tuple of Double values
    ///   - toRange: a tuple of Double values
    /// - Returns: an x coordinate represented in a Double value
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return self
    }
    
    /**
        Formats the current Double instance to a String representation using two decimals

        - Returns: String of the representation for this Double
    **/
    func formatNumber() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        if let str = formatter.string(from: number) {
            return str
        }
        return ""
    }
    
    static func convertNumberWithNotation(number value: Double, decimals: Bool = true) -> String {
        guard !value.isNaN else { return "" }
        let isNegative = value < 0
        let num = abs(value)
        let suffix = ["", "K", "M", "B", "T", "P", "E", "Z", "Y"]
        if num < 1000 {
            return String(format: "%g", value)
        }
        for i in 0 ..< suffix.count {
            let size = pow(10.0, (Double(i) + 1.0) * 3.0)
            let numFormated = Int(num / size)
            if numFormated < 1000 {
                let prettyNum = Double(num / size)
                let format: String
                let abbrevNum: String

                if !decimals {
                    return "\(numFormated)\(suffix[i + 1])"
                } else {
                    format = prettyNum == floor(prettyNum) ? "0.0" : "0.1"
                }

                if isNegative {
                    abbrevNum = "-\(prettyNum.format(formatToApply: format))\(suffix[i + 1])"
                } else {
                    abbrevNum = "\(prettyNum.format(formatToApply: format))\(suffix[i + 1])"
                }

                return abbrevNum
            }
        }

        return ""
    }
}
