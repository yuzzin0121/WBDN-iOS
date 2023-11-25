//
//  UIColor+Extensions.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit

extension UIColor {
    class var customNavy: UIColor! { return UIColor(named: "customNavy")}
    class var customLightNavy: UIColor! { return UIColor(named: "customLightNavy")}
    class var customRed: UIColor! { return UIColor(named: "customRed")}
    class var customGray: UIColor! { return UIColor(named: "customGray")}
    class var customLightGray: UIColor! { return UIColor(named: "customLightGray")}
    class var customLightGray2: UIColor! { return UIColor(named: "customLightGray2")}
    class var customLightGray3: UIColor! { return UIColor(named: "customLightGray3")}
    class var customSkyBlue: UIColor! { return UIColor(named: "customSkyBlue")}
    class var customYellow: UIColor! { return UIColor(named: "customYellow")}
    class var customMidGray: UIColor! { return UIColor(named: "customMidGray")}
    
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
