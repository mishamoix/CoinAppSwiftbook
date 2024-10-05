//
//  FontModifier.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import SwiftUI

public struct FontModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    let keyPath: KeyPath<FontSet, UIFont>

    public func body(content: Content) -> some View {
        content.font(Font(theme.fonts[keyPath: keyPath]))
    }
}

public extension View {
    func appFont(_ font: KeyPath<FontSet, UIFont>) -> some View {
        self.modifier(FontModifier(keyPath: font))
    }
}
