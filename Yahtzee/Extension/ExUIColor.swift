//
//  Extension.swift
//  Yahtzee
//

import UIKit
import SwiftUI

extension UIColor {
    
   convenience init(red: Int, green: Int, blue: Int) {
       self.init(red: red, green: green, blue: blue, alpha: 1.0)
   }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Double) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }

    convenience init(hex: String, alpha: Double) {

        if (hex.hasPrefix("#")) {
            assert( hex.count == 7 , "Invalid component")
        } else {
            assert( hex.count == 6 , "Invalid component")
        }

        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }


}
