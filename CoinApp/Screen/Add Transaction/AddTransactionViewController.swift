//
//  Add Transaction.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI
import Nexus


final class AddTransactionViewController: UIHostingController<AnyView> {
    init(with viewModel: AddTransactionViewModel, themeManager: ThemeManager) {
        super.init(rootView: AnyView(AddTransactionView(viewModel: viewModel).environmentObject(themeManager)))
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
