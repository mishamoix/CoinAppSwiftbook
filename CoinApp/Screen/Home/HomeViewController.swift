//
//  HomeViewController.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit
import SwiftUI
import Nexus

final class HomeViewController: UIHostingController<AnyView> {

    private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel, themeManager: ThemeManager) {
        self.viewModel = viewModel
        super.init(
            rootView: AnyView(
                HomeView(viewModel: viewModel).environmentObject(themeManager)
            )
        )
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        viewModel.start()
    }
}
