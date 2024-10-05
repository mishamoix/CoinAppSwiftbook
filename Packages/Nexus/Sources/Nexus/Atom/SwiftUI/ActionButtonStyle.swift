//
//  ActionButtonStyle.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import SwiftUI

public struct ActionButtonStyle: ButtonStyle {

    public enum Style {
        case affirm
        case negative
    }

    @EnvironmentObject var theme: ThemeManager
    let style: Style

    public init(style: Style) {
        self.style = style
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .appBackground(bgColor)
            .appForeground(\.bodyText)
            .font(Font(theme.fonts.button))
    }

    private var bgColor: KeyPath<ColorSet, UIColor> {
        switch style {
        case .affirm:
            return \.affirmButton
        case .negative:
            return \.negativeButton
        }
    }
}
