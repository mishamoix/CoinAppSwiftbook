//
//  SearchViewController.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import UIKit
import SwiftUI

final class SearchViewController: UIHostingController<SearchView> {
    init(viewModel: SearchViewModel) {
        super.init(rootView: SearchView(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
