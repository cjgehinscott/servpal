//
// Created by Matt on 11/7/17.
// Copyright (c) 2017 ServPal. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    static let primary      = UIColor(hex: "30B374")
    static let primaryDark  = UIColor(hex: "008248")
    static let primaryLight = UIColor(hex: "6AE6A3")
    static let accent       = UIColor(hex: "28384C")

    static let background      = UIColor(hex: "F1F1F1")
    static let accentSecondary = UIColor(hex: "8CAFDD")

    convenience init(hex: String, alpha: Float = 1.0) {
        let scanner       = Scanner(string: hex)
        var color: UInt32 = 0;
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r    = CGFloat(Float(Int(color >> 16) & mask) / 255.0)
        let g    = CGFloat(Float(Int(color >> 8) & mask) / 255.0)
        let b    = CGFloat(Float(Int(color) & mask) / 255.0)

        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
