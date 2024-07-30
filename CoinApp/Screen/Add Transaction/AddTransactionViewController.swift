//
//  Add Transaction.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI

final class AddTransactionViewController: UIHostingController<AddTransactionView> {
    init(with viewModel: AddTransactionViewModel) {
        super.init(rootView: AddTransactionView(viewModel: viewModel))
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
