//
//  BlueTheme.swift
//  CoinApp
//
//  Created by mike on 06/10/2024.
//

import UIKit
import Nexus

struct BlueColorSet: ColorSet {
    let accent = UIColor(light: UIColor(hex: "#4f46e5"), dark: UIColor(hex: "#818cf8"))

    let background = UIColor(light: UIColor(hex: "#f1f5f9"), dark: UIColor(hex: "#020617"))

    let backgroundSecondary = UIColor(light: UIColor(hex: "#f8fafc"), dark: UIColor(hex: "#1e293b"))

    let backgroundPositive = UIColor(light: UIColor(hex: "#d1fae5"), dark: UIColor(hex: "#34d399"))

    let backgroundNegative = UIColor(light: UIColor(hex: "#fecaca"), dark: UIColor(hex: "#7F1D1D"))

    let text = UIColor(light: UIColor(hex: "#171717"), dark: UIColor(hex: "#fafafa"))

    let textSecondary = UIColor(light: UIColor(hex: "#737373"), dark: UIColor(hex: "#d4d4d4"))

    let textPositive = UIColor(light: UIColor(hex: "#059669"), dark: UIColor(hex: "#34d399"))

    let textNegative = UIColor(light: UIColor(hex: "#dc2626"), dark: UIColor(hex: "#FECACA"))

    let textInversed = UIColor(light: UIColor(hex: "#fafafa"), dark: UIColor(hex: "#fafafa"))

    let border = UIColor(light: UIColor(hex: "#f9fafb"), dark: UIColor(hex: "#374151"))

    let shadow = UIColor(light: UIColor(hex: "#4f46e5").withAlphaComponent(0.2), dark: UIColor(hex: "#818cf8").withAlphaComponent(0.2))
}

let BlueTheme = Theme(name: "Blue", colors: BlueColorSet(), fonts: AppFontSet())
