//
//  NView.swift
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public final class NView: UIView {
    public let n: NViewConfiguration<NView>

    public override init(frame: CGRect) {
        n = NViewConfiguration(themeManager: ThemeManager.shared)
        super.init(frame: frame)
        n.owner = self
    }

    public convenience init(configurator: (NViewConfiguration<NView>) -> Void) {
        self.init(frame: .zero)
        configurator(n)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
