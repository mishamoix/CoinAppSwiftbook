//
//  AppFonts.swift
//  CoinApp
//
//  Created by mike on 06/10/2024.
//

import UIKit
import Nexus

struct AppFontSet: FontSet {
    let header = UIFont.systemFont(ofSize: 32, weight: .bold)

    let headerSecondary = UIFont.systemFont(ofSize: 20, weight: .semibold)

    let headerTertiary = UIFont.systemFont(ofSize: 20, weight: .light)

    let text = UIFont.systemFont(ofSize: 18, weight: .regular)

    let caption = UIFont.systemFont(ofSize: 14, weight: .light)

    let button = UIFont.systemFont(ofSize: 18, weight: .semibold)
}
