//
//  MainCoordinator.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit
import Nexus

protocol MainCoordinatorProtocol: AnyObject {
    func goBack()
    func goToSearch()
    func goToAddTransaction(with id: String)
    func goToAsset(with id: String)
}

final class MainCoordinator {

    private let navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }()
    private let network = NetworkManagerImpl()
    private let themeManager = ThemeManager.shared

    private let dbSetup = DatabaseSetup()
    private lazy var assetService = AssetService(networkProvider: CoinProvider(network: network), dbProvider: AssetDatabaseProvider(dataStack: dbSetup.dataStack), transactionsProvider: TransactionDatabaseProvider(dataStack: dbSetup.dataStack))
    private lazy var refreshService = RefreshService(assetService: assetService)

    init(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        dbSetup.setup()
    }

    func run() {
        let viewModel = HomeViewModel(service: assetService, coordinator: self)
        navigationController.setViewControllers([HomeViewController(viewModel: viewModel, themeManager: themeManager)], animated: false)

        refreshService.scheduleUpdate()
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToSearch() {
        let viewModel = SearchViewModel(service: assetService, coordinator: self)
        navigationController.pushViewController(SearchViewController(viewModel: viewModel, themeManager: themeManager), animated: true)
    }
    
    func goToAddTransaction(with id: String) {
        let viewModel = AddTransactionViewModel(assetId: id, service: assetService, coordinator: self)
        navigationController.pushViewController(AddTransactionViewController(with: viewModel, themeManager: themeManager), animated: true)
    }

    func goToAsset(with id: String) {
        let viewModel = AssetCardViewModel(assetId: id, service: assetService, coordinator: self)
        navigationController.pushViewController(AssetCardViewController(with: viewModel, themeManager: themeManager), animated: true)
    }
}
