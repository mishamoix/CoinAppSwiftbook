//
//  HomeViewController.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit
import SwiftUI

final class HomeViewController: UIHostingController<HomeView> {

    private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(rootView: HomeView(viewModel: viewModel))
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
