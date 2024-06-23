//
//  App.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import UIKit

final class App {

    private let window: UIWindow
    private lazy var coordinator = MainCoordinator(window: window)

    init(window: UIWindow) {
        self.window = window
    }

    func run() {
        coordinator.run()
    }
}
