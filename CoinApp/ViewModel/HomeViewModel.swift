//
//  HomeViewModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {

    @Published var state: State<[AssetModel]> = .idle

    private let provider: CoinProvidable

    init(provider: CoinProvidable) {
        self.provider = provider
    }

    func start() {
        load()
    }

    func reload() {
        load()
    }
}

private extension HomeViewModel {
    func load() {
        Task { @MainActor in
            state = .loading
            do {
                let coins = try await provider.fetchAllCoins()
                let assets = coins.map({ AssetModel(coin: $0) })
                state = .loaded(assets)
            } catch {
                state = .error(error)
            }
        }

    }
}
