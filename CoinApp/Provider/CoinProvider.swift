//
//  CoinProvider.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

protocol CoinProvidable {
    func fetchAllCoins() async throws -> Coins
}

final class CoinProvider {

    private let network: NetworkManager

    init(network: NetworkManager) {
        self.network = network
    }
}

extension CoinProvider: CoinProvidable {
    func fetchAllCoins() async throws -> Coins {
        let builder = builder
            .path("/coins/markets")
            .query(["vs_currency": "usd"])

        let result: Coins = try await network.fetch(builder: builder)
        return result
    }
}

private extension CoinProvider {
    var builder: RequestBuilder {
        RequestBuilder()
            .setNeedAuth()
            .path(NetworkConstants.basePath)
    }
}
