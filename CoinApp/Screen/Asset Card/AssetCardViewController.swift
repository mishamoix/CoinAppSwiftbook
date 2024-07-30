//
//  AssetCardViewController.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI

final class AssetCardViewController: UIHostingController<AssetCardView> {
    init(with viewModel: AssetCardViewModel) {
        super.init(rootView: AssetCardView(viewModel: viewModel))
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
