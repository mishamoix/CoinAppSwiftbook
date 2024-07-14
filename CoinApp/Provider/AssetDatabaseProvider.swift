//
//  AssetDatabaseProvider.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import CoreStore

protocol AssetDatabaseProvidable {
    func fetchAllAssets() async throws -> [AssetModel]
    func save(coins: [CoinModel])

    func update(quantity: AssetModel.Quantity, for coin: CoinModel)
}

final class AssetDatabaseProvider {

    private let dataStack: DataStack

    init(dataStack: DataStack) {
        self.dataStack = dataStack
    }
}

extension AssetDatabaseProvider: AssetDatabaseProvidable {
    func fetchAllAssets() async throws -> [AssetModel] {
        return try await withUnsafeThrowingContinuation { continuation in
            dataStack.perform { transaction in
                let assets = try transaction.fetchAll(From<Asset>().orderBy(.ascending(\.sort)))
                return assets.map(\.toModel)
            } completion: { result in
                switch result {
                case .success(let models):
                    continuation.resume(returning: models)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func save(coins: [CoinModel]) {
        dataStack.perform(asynchronous: { transaction in
            let existingAssets = try transaction.fetchAll(From<Asset>())
            let existingAssetsMap: [String: Asset] = existingAssets.reduce(into: [:]) { partialResult, asset in
                partialResult[asset.id] = asset
            }

            for (idx, coinModel) in coins.enumerated() {
                if let existing = existingAssetsMap[coinModel.id] {
                    existing.update(sort: idx, coin: coinModel)
                } else {
                    let newAsset = transaction.create(Into<Asset>())
                    newAsset.update(sort: idx, coin: coinModel)
                }
            }
        }, completion: { _ in })
    }

    func update(quantity: AssetModel.Quantity, for coin: CoinModel) {
        dataStack.perform { transaction in
            guard let asset = try transaction.fetchOne(From<Asset>().where(\.id == coin.id)) else { return }

            asset.avgPrice = quantity.avgPrice
            asset.count = quantity.count
        } completion: { _ in }
    }
}
