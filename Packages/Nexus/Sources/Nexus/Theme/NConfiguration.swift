//
//  NConfiguration.swift
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public class NConfiguration<Type: AnyObject & Hashable>: NObserver {

    weak var owner: Type? {
        didSet {
            configureView()
        }
    }

    private var themeManager: ThemeManager

    var theme: Theme {
        themeManager.theme
    }

    deinit {
        themeManager.remove(observer: self)
        NotificationCenter.default.removeObserver(self)
    }

    init(themeManager: ThemeManager) {
        self.themeManager = themeManager

        themeManager.add(observer: self)
    }

    public func styleDidChange() { }

    func configureView() { }
}
