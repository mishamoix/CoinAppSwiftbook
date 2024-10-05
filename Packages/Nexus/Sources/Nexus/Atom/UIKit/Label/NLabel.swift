//
//  NLabel.swift
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public final class NLabel: UILabel {
    public let n: NLabelConfiguration<NLabel>

    public override init(frame: CGRect) {
        n = NLabelConfiguration(themeManager: ThemeManager.shared)
        super.init(frame: frame)
        n.owner = self
    }

    public convenience init(configurator: (NLabelConfiguration<NLabel>) -> Void) {
        self.init(frame: .zero)
        configurator(n)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
