//
//  DefaultTheme.swift
//
//
//  Created by mike on 07/09/2024.
//

import Foundation
import SwiftUI

struct DefaultColorSet: ColorSet {
    let accent = UIColor.blue

    let background = UIColor.white

    let backgroundSecondary = UIColor.lightGray

    let backgroundPositive = UIColor.green.withAlphaComponent(0.2)

    let backgroundNegative = UIColor.red.withAlphaComponent(0.2)

    let text = UIColor.black

    let textSecondary = UIColor.gray

    let textPositive = UIColor.green

    let textNegative = UIColor.red

    let textInversed = UIColor.white

    let border = UIColor.lightGray

    let shadow = UIColor.black.withAlphaComponent(0.1)
}

struct DefaultFontSet: FontSet {
    let header = UIFont.systemFont(ofSize: 32, weight: .bold)

    let headerSecondary = UIFont.systemFont(ofSize: 20, weight: .semibold)

    let headerTertiary = UIFont.systemFont(ofSize: 16, weight: .light)

    let text = UIFont.systemFont(ofSize: 15, weight: .regular)

    let caption = UIFont.systemFont(ofSize: 14, weight: .light)

    let button = UIFont.systemFont(ofSize: 16, weight: .medium)
}

public let DefaultTheme = Theme(name: "Default", colors: DefaultColorSet(), fonts: DefaultFontSet())
