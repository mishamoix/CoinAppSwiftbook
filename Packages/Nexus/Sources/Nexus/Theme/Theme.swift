//
//  Theme.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import Foundation

public struct Theme {
    public let name: String
    public let colors: ColorSet
    public let fonts: FontSet

    public init(name: String, colors: ColorSet, fonts: FontSet) {
        self.name = name
        self.colors = colors
        self.fonts = fonts
    }
}
