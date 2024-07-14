//
//  MainCoordinator.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func goBack()
    func goToSearch()
    func goToPurchase()
    func goToAsset()
}

final class MainCoordinator {

    private let navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }()
    private let network = NetworkManagerImpl()

    private let dbSetup = DatabaseSetup()
    private lazy var assetService = AssetService(networkProvider: CoinProvider(network: network), dbProvider: AssetDatabaseProvider(dataStack: dbSetup.dataStack))

    init(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        dbSetup.setup()
    }

    func run() {
        let viewModel = HomeViewModel(service: assetService, coordinator: self)
        navigationController.setViewControllers([HomeViewController(viewModel: viewModel)], animated: false)
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToSearch() {
        let viewModel = SearchViewModel(service: assetService, coordinator: self)
        navigationController.pushViewController(SearchViewController(viewModel: viewModel), animated: true)
    }
    
    func goToPurchase() {

    }
    
    func goToAsset() {

    }
}
