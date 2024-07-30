//
//  AssetService.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import Combine

enum AssetServiceState {
    case idle
    case fetching
    case fetched(data: [AssetModel])
    case error(Error)

    var hasAnyData: Bool {
        switch self {
        case .idle, .fetching, .error:
            return false
        case .fetched:
            return true
        }
    }
}

protocol AssetServiceProtocol {
    var assets: AnyPublisher<AssetServiceState, Never> { get }

    func loadData()

    func subscribeToFullAsset(by id: String) -> AnyPublisher<FullAssetInfoModel, Never>

    func saveTransaction(price: Double, quantity: Double, operation: TransactionModel.Operation, assetId: String) -> Bool
}

final class AssetService {
    private var cancellable = Set<AnyCancellable>()

    private let networkProvider: CoinProvidable
    private let dbProvider: AssetDatabaseProvidable
    private let transactionsProvider: TransactionDatabaseProvidable

    private let assetsPublisher = CurrentValueSubject<AssetServiceState, Never>(.idle)

    init(networkProvider: CoinProvidable, dbProvider: AssetDatabaseProvidable, transactionsProvider: TransactionDatabaseProvidable) {
        self.networkProvider = networkProvider
        self.dbProvider = dbProvider
        self.transactionsProvider = transactionsProvider

        setup()
    }
}

extension AssetService: AssetServiceProtocol {
    var assets: AnyPublisher<AssetServiceState, Never> {
        assetsPublisher.eraseToAnyPublisher()
    }
    
    func loadData() {
        Task {
            if case .idle = self.assetsPublisher.value {
                self.assetsPublisher.value = .fetching
            }

            do {
                let coins = try await networkProvider.fetchAllCoins()
                dbProvider.save(coins: coins)
            } catch {
                if !self.assetsPublisher.value.hasAnyData {
                    self.assetsPublisher.value = .error(error)
                }
            }
        }
    }

    func subscribeToFullAsset(by id: String) -> AnyPublisher<FullAssetInfoModel, Never> {
        return Publishers.CombineLatest(
            transactionsProvider.subscribeForTransactions(with: id),
            dbProvider.subscribeToAsset(with: id)
        )
        .map({ (transactions, model) in
            FullAssetInfoModel(asset: model, transactions: transactions)
        })
        .eraseToAnyPublisher()
    }

    func saveTransaction(price: Double, quantity: Double, operation: TransactionModel.Operation, assetId: String) -> Bool {
        guard let asset = dbProvider.fetchAsset(by: assetId) else {
            return false
        }

        if operation == .sell, quantity > asset.quantity?.count ?? 0 {
            return false
        }

        let model = TransactionModel(id: UUID().uuidString, coinId: assetId, operation: operation, quantity: quantity, price: price, date: Date().timeIntervalSince1970)

        transactionsProvider.add(transaction: model)


        if let transaction = transactionsProvider.fetchTransactions(by: assetId),
           let quantity = recalculateAvgPrice(transactions: transaction)
        {
            dbProvider.update(quantity: quantity, for: asset.coin)
        }

        return true
    }
}

private extension AssetService {
    func setup() {
        dbProvider
            .allAssetsPublisher
            .compactMap({ $0 })
            .map({ models in
                return AssetServiceState.fetched(data: models)
            })
            .sink { [weak self] state in
                self?.assetsPublisher.value = state
            }
            .store(in: &cancellable)
    }

    func recalculateAvgPrice(transactions: [TransactionModel]) -> AssetModel.Quantity? {
        if transactions.isEmpty {
            return nil
        }

        let sortedTransactions = transactions.sorted(by: { $0.date < $1.date })

        var totalQuantity = 0.0
        var totalCost = 0.0

        for transaction in sortedTransactions {
            switch transaction.operation {
            case .buy:
                totalQuantity += transaction.quantity
                totalCost += transaction.value
            case .sell:
                if totalQuantity >= transaction.quantity {
                    let avgPrice = totalCost / totalQuantity
                    totalQuantity -= transaction.quantity
                    totalCost -= transaction.quantity * avgPrice
                } else {
                    totalQuantity = 0
                    totalCost = 0
                }
            }
        }

        let avgPrice = totalQuantity != 0 ? totalCost / totalQuantity : 0
        return AssetModel.Quantity(avgPrice: avgPrice, count: totalQuantity)
    }
}
