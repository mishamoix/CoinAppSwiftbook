//
//  HomeViewModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var state: State<[AssetModel]> = .idle {
        didSet {
            recalculatePnL()
        }
    }
    @Published var commonPnL: CommonPnLModel?

    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: MainCoordinatorProtocol?
    private let service: AssetServiceProtocol


    init(service: AssetServiceProtocol, coordinator: MainCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator

        setup()
    }

    func start() {
        load()
    }

    func reload() {
        load()
    }

    func searchTapped() {
        coordinator?.goToSearch()
    }

    func assetTapped(with id: String) {
        coordinator?.goToAsset(with: id)
    }

}

private extension HomeViewModel {
    func load() {
        service.loadData()
    }

    func setup() {
        service.assets
            .map({ value -> State<[AssetModel]> in
                switch value {
                case .idle:
                    return .idle
                case .fetching:
                    return .loading
                case let .fetched(data):
                    return .loaded(data)
                case .error(let error):
                    return .error(error)
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }

    func recalculatePnL() {
        guard case let .loaded(models) = state else { return }

        var totalCurrentValue: Double = 0
        var totalInvestedValue: Double = 0

        for model in models {
            if let quantity = model.quantity {
                totalCurrentValue += quantity.count * model.coin.currentPrice
                totalInvestedValue += quantity.count * quantity.avgPrice
            }
        }

        if totalInvestedValue == 0 {
            print("No investments found.")
            return
        }

        let totalPnL = totalCurrentValue - totalInvestedValue
        let percentPnL = (totalCurrentValue / totalInvestedValue - 1)

        self.commonPnL = CommonPnLModel(
            value: totalCurrentValue,
            percent: percentPnL,
            pnlValue: totalPnL
        )

    }
}
