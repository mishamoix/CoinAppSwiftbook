//
//  SearchViewController.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import UIKit
import SwiftUI
import Nexus

final class SearchViewController: UIHostingController<AnyView> {
    init(viewModel: SearchViewModel, themeManager: ThemeManager) {
        super.init(rootView: AnyView(SearchView(viewModel: viewModel).environmentObject(themeManager)))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
