//
//  MainCoordinator.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit

protocol MainCoordinatorProtocol {
    func goToMain()
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

    init(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func run() {
        let viewModel = HomeViewModel(provider: CoinProvider(network: network))
        navigationController.setViewControllers([HomeViewController(viewModel: viewModel)], animated: false)
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func goToMain() {
        
    }
    
    func goToSearch() {

    }
    
    func goToPurchase() {

    }
    
    func goToAsset() {

    }
}
