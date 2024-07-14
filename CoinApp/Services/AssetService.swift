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
    case fetched(data: [AssetModel], fromDatabase: Bool)
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
}

final class AssetService {

    private let networkProvider: CoinProvidable
    private let dbProvider: AssetDatabaseProvidable

    private let assetsPublisher = CurrentValueSubject<AssetServiceState, Never>(.idle)

    init(networkProvider: CoinProvidable, dbProvider: AssetDatabaseProvidable) {
        self.networkProvider = networkProvider
        self.dbProvider = dbProvider
    }
}

extension AssetService: AssetServiceProtocol {
    var assets: AnyPublisher<AssetServiceState, Never> {
        assetsPublisher.eraseToAnyPublisher()
    }
    
    func loadData() {
        Task {
            self.assetsPublisher.value = .fetching

            do {
                let assets = try await dbProvider.fetchAllAssets()
                if !assets.isEmpty {
                    self.assetsPublisher.value = .fetched(data: assets, fromDatabase: true)
                }
            } catch { 
                print(error)
            }

            do {
                let map: [String: AssetModel]?
                if case let .fetched(data, _) = self.assetsPublisher.value {
                    map = data.reduce(into: [:], { partialResult, model in
                        partialResult[model.id] = model
                    })
                } else {
                    map = nil
                }


                let coins = try await networkProvider.fetchAllCoins()
                let assets = coins
                    .enumerated()
                    .map({ $0.element.toAsset(sort: $0.offset, previous: map?[$0.element.id]) })

                self.assetsPublisher.value = .fetched(data: assets, fromDatabase: false)

                dbProvider.save(coins: coins)
            } catch {
                if !self.assetsPublisher.value.hasAnyData {
                    self.assetsPublisher.value = .error(error)
                }
            }


        }
    }
}
