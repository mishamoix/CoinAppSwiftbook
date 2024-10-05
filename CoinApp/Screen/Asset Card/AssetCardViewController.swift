//
//  AssetCardViewController.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI
import Nexus


final class AssetCardViewController: UIHostingController<AnyView> {
    init(with viewModel: AssetCardViewModel, themeManager: ThemeManager) {
        super.init(rootView: AnyView(AssetCardView(viewModel: viewModel).environmentObject(themeManager)))
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
