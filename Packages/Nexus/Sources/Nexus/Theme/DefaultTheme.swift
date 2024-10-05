//
//  DefaultTheme.swift
//
//
//  Created by mike on 07/09/2024.
//

import Foundation
import SwiftUI

struct GrayColorSet: ColorSet {
    let primary = UIColor(light: UIColor(hex: "bdc3c7"), dark: UIColor(hex: "7f8c8d"))
    let secondary = UIColor(light: UIColor(hex: "95a5a6"), dark: UIColor(hex: "7f8c8d"))
    let affirmButton = UIColor(light: UIColor(hex: "7f8c8d"), dark: UIColor(hex: "bdc3c7"))
    let negativeButton = UIColor(light: UIColor(hex: "95a5a6"), dark: UIColor(hex: "7f8c8d"))
    let bodyText = UIColor(light: UIColor(hex: "2c3e50"), dark: UIColor(hex: "ecf0f1"))
    let textBox = UIColor(light: UIColor(hex: "ecf0f1"), dark: UIColor(hex: "34495e"))
}

struct GrayFontSet: FontSet {
    let title = UIFont(name: "Futura-Bold", size: 28)!
    let subtitle = UIFont(name: "Futura-Medium", size: 22)!
    let body = UIFont(name: "Futura", size: 16)!
    let button = UIFont(name: "Futura-Medium", size: 18)!
}

public let grayTheme = Theme(name: "Gray", colors: GrayColorSet(), fonts: GrayFontSet())
