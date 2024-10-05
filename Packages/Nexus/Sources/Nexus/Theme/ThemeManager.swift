//
//  ThemeManager.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import Foundation
import UIKit

class AppearanceObserver: UIView {
    var onAppearanceChange: ((UIUserInterfaceStyle) -> Void)?

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            onAppearanceChange?(traitCollection.userInterfaceStyle)
        }
    }
}

public class ThemeManager: ObservableObject {
    @Published public private(set) var theme: Theme

    public static let shared = ThemeManager(theme: grayTheme)
    private var observers = NSHashTable<NObserver>.weakObjects()
    private let appearanceObserver = AppearanceObserver()

    public var colors: ColorSet {
        return theme.colors
    }

    public var fonts: FontSet {
        return theme.fonts
    }

    public func updateTheme(_ newTheme: Theme) {
        theme = newTheme

        notifyAllObserver()
    }

    init(theme: Theme) {
        self.theme = theme

        appearanceObserver.onAppearanceChange = { [weak self] _ in
            self?.notifyAllObserver()
        }

        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                window.addSubview(self.appearanceObserver)
                self.appearanceObserver.isHidden = true
            }
        }
    }
}

extension ThemeManager: NObservable {
    public func add(observer: any NObserver) {
        observers.add(observer)
    }

    public func remove(observer: any NObserver) {
        observers.remove(observer)
    }
}

private extension ThemeManager {
    func notifyAllObserver() {
        observers.allObjects.forEach {
            $0.styleDidChange()
        }
    }
}
