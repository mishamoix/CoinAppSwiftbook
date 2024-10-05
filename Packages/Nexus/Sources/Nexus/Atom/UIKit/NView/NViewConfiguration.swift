//
//  NViewConfiguration.swift
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public class NViewConfiguration<Type: UIView>: NConfiguration<Type> {
    public var backgroundColor: KeyPath<ColorSet, UIColor>? = nil {
        didSet {
            if let color = backgroundColor  {
                owner?.backgroundColor = theme.colors[keyPath: color]
            } else {
                owner?.backgroundColor = .clear
            }
        }
    }

    public var borderColor: KeyPath<ColorSet, UIColor>? = nil {
        didSet {
            if let color = borderColor {
                owner?.layer.borderColor = theme.colors[keyPath: color].cgColor
            } else {
                owner?.layer.borderColor = nil
            }
        }
    }

    public var borderWidth: CGFloat = 0 {
        didSet {
            owner?.layer.borderWidth = borderWidth
        }
    }

    public override func styleDidChange() {
        super.styleDidChange()
        retrigger(self, keyPath: \.backgroundColor)
        retrigger(self, keyPath: \.borderColor)
    }

    override func configureView() {
        owner?.translatesAutoresizingMaskIntoConstraints = false
    }
}
