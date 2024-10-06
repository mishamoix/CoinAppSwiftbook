//
//  ColorSet.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import SwiftUI

public protocol ColorSet {
    var accent: UIColor { get }

    var background: UIColor { get }
    var backgroundSecondary: UIColor { get }
    var backgroundPositive: UIColor { get }
    var backgroundNegative: UIColor { get }

    var text: UIColor { get }
    var textSecondary: UIColor { get }
    var textPositive: UIColor { get }
    var textNegative: UIColor { get }
    var textInversed: UIColor { get }

    var border: UIColor { get }
    var shadow: UIColor { get }
}

public extension UIColor {
    convenience init(
        light lightColor: @escaping @autoclosure () -> UIColor,
        dark darkColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightColor()
            case .dark:
                return darkColor()
            case .unspecified:
                return lightColor()
            @unknown default:
                return lightColor()
            }
        }
    }

    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, alpha: Double(a) / 255)
    }
}
