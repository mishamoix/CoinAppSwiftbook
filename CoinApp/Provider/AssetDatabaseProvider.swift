//
//  AssetDatabaseProvider.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import CoreStore
import Combine

protocol AssetDatabaseProvidable {

    var allAssetsPublisher: AnyPublisher<[AssetModel]?, Never> { get }

    func save(coins: [CoinModel])
    func update(quantity: AssetModel.Quantity, for coin: CoinModel)
    func subscribeToAsset(with id: String) -> AnyPublisher<AssetModel, Never>
    func fetchAsset(by id: String) -> AssetModel?
}

final class AssetDatabaseProvider {

    private var cancellable = Set<AnyCancellable>()

    private let allAssetsSubject = CurrentValueSubject<[AssetModel]?, Never>(nil)

    private let dataStack: DataStack

    init(dataStack: DataStack) {
        self.dataStack = dataStack

        setup()
    }
}

extension AssetDatabaseProvider: AssetDatabaseProvidable {
    var allAssetsPublisher: AnyPublisher<[AssetModel]?, Never> {
        allAssetsSubject.eraseToAnyPublisher()
    }
//    func fetchAllAssets() async throws -> [AssetModel] {
//        return try await withUnsafeThrowingContinuation { continuation in
//            dataStack.perform { transaction in
//                let assets = try transaction.fetchAll(From<Asset>().orderBy(.ascending(\.sort)))
//                return assets.map(\.toModel)
//            } completion: { result in
//                switch result {
//                case .success(let models):
//                    continuation.resume(returning: models)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }

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

    func subscribeToAsset(with id: String) -> AnyPublisher<AssetModel, Never> {
        guard let asset = try? dataStack.fetchOne(From<Asset>().where(\.id == id)) else {
            return Empty<AssetModel, Never>().eraseToAnyPublisher()
        }

        return asset
            .asPublisher(in: self.dataStack)
            .reactive
            .snapshot(emitInitialValue: true)
            .compactMap { snapshot in
                return snapshot?.asPublisher(in: self.dataStack)
            }
            .compactMap { publisher in
                return publisher.object?.toModel
            }
            .eraseToAnyPublisher()
    }

    func fetchAsset(by id: String) -> AssetModel? {
        try? dataStack.fetchOne(From<Asset>().where(\.id == id))?.toModel
    }
}

private extension AssetDatabaseProvider {
    func setup() {
        dataStack
            .publishList(From<Asset>().orderBy(.ascending(\.sort)))
            .reactive
            .snapshot(emitInitialValue: true)
            .map { snapshot in
                snapshot
                    .compactMap(\.object)
                    .map(\.toModel)
            }
            .sink { [weak self] models in
                self?.allAssetsSubject.value = models
            }
            .store(in: &cancellable)
    }
}
