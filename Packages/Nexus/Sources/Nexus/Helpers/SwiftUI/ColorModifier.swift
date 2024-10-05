//
//  ColorModifier.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import SwiftUI

public struct ForegroundModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    let keyPath: KeyPath<ColorSet, UIColor>

    public func body(content: Content) -> some View {
        content.foregroundStyle(Color(theme.colors[keyPath: keyPath]))
    }
}

public struct BackgroundModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    let keyPath: KeyPath<ColorSet, UIColor>

    public func body(content: Content) -> some View {
        content.background(Color(theme.colors[keyPath: keyPath]))
    }
}

public extension View {
    func appForeground(_ color: KeyPath<ColorSet, UIColor>) -> some View {
        self.modifier(ForegroundModifier(keyPath: color))
    }

    func appBackground(_ color: KeyPath<ColorSet, UIColor>) -> some View {
        self.modifier(BackgroundModifier(keyPath: color))
    }
}
