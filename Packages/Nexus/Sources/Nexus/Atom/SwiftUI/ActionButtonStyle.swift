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
            .frame(maxWidth: .infinity)
            .padding()
            .appBackground(bgColor)
            .appForeground(\.textInversed)
            .appFont(\.button)
            .cornerRadius(12)
            .shadow(color: Color(theme.colors.shadow), radius: 5, x: 0, y: 5)
    }

    private var bgColor: KeyPath<ColorSet, UIColor> {
        switch style {
        case .affirm:
            return \.accent
        case .negative:
            return \.backgroundNegative
        }
    }
}
