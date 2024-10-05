//
//  NLabelConfiguration.swift
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public class NLabelConfiguration<Type: UILabel>: NViewConfiguration<Type> {

    public var action: (() -> Void)?

    public var textColor: KeyPath<ColorSet, UIColor>? = nil {
        didSet {
            if let color = textColor  {
                owner?.textColor = theme.colors[keyPath: color]
            } else {
                owner?.textColor = .clear
            }
        }
    }

    public var font: KeyPath<FontSet, UIFont>? = nil {
        didSet {
            if let font {
                owner?.font = theme.fonts[keyPath: font]
            } else {
                owner?.font = UIFont.systemFont(ofSize: 12)
            }
        }
    }

    public var text: String? = nil {
        didSet {
            owner?.text = text
        }
    }

    public var numberOfLines: Int = 0 {
        didSet {
            owner?.numberOfLines = numberOfLines
        }
    }

    public override func styleDidChange() {
        super.styleDidChange()
        retrigger(self, keyPath: \.font)
        retrigger(self, keyPath: \.textColor)
    }

    override func configureView() {
        super.configureView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        owner?.addGestureRecognizer(tapGesture)
        owner?.isUserInteractionEnabled = true

        retrigger(self, keyPath: \.numberOfLines)
    }

    @objc private func didTap() {
        action?()
    }
}

