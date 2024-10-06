//
//  YellowTheme.swift
//  CoinApp
//
//  Created by mike on 06/10/2024.
//

import UIKit
import Nexus

struct YellowColorSet: ColorSet {
    let accent = UIColor(light: UIColor(hex: "#FDE047"), dark: UIColor(hex: "#facc15"))

    let background = UIColor(light: UIColor(hex: "#f5f5f4"), dark: UIColor(hex: "#0c0a09"))

    let backgroundSecondary = UIColor(light: UIColor(hex: "#fafaf9"), dark: UIColor(hex: "#292524"))

    let backgroundPositive = UIColor(light: UIColor(hex: "#d1fae5"), dark: UIColor(hex: "#34d399"))

    let backgroundNegative = UIColor(light: UIColor(hex: "#fecaca"), dark: UIColor(hex: "#7F1D1D"))

    let text = UIColor(light: UIColor(hex: "#171717"), dark: UIColor(hex: "#fafafa"))

    let textSecondary = UIColor(light: UIColor(hex: "#737373"), dark: UIColor(hex: "#d4d4d4"))

    let textPositive = UIColor(light: UIColor(hex: "#059669"), dark: UIColor(hex: "#34d399"))

    let textNegative = UIColor(light: UIColor(hex: "#dc2626"), dark: UIColor(hex: "#FECACA"))

    let textInversed = UIColor(light: UIColor(hex: "#422006"), dark: UIColor(hex: "#fafafa"))

    let border = UIColor(light: UIColor(hex: "#f9fafb"), dark: UIColor(hex: "#374151"))

    let shadow = UIColor(light: UIColor(hex: "#FDE047").withAlphaComponent(0.2), dark: UIColor(hex: "#facc15").withAlphaComponent(0.2))
}

let YellowTheme = Theme(name: "Yellow", colors: YellowColorSet(), fonts: AppFontSet())
