//
//  AddTransactionViewModel.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import Combine

final class AddTransactionViewModel: ObservableObject {

    enum FocusedField {
        case none
        case quantity
        case price
        case totalSpent
    }

    @Published private(set) var asset: State<FullAssetInfoModel> = .idle {
        didSet {
            if case let .loaded(model) = asset {
                price = model.asset.coin.currentPrice
                currentFocusedField = .price
            }
        }
    }

    @Published var selectedTab: TransactionModel.Operation = .buy
    @Published var price: Double = 0
    @Published var quantity: Double = 0
    @Published var totalSpent: Double = 0

    private var cancellable = Set<AnyCancellable>()

    private var previousFocusedField: FocusedField = .none
    private var currentFocusedField: FocusedField = .none {
        willSet {
            if newValue != currentFocusedField {
                previousFocusedField = currentFocusedField
            }
        }
    }

    private let assetId: String
    private let service: AssetServiceProtocol
    private weak var coordinator: MainCoordinator?

    init(assetId: String, service: any AssetServiceProtocol, coordinator: MainCoordinator?) {
        self.assetId = assetId
        self.service = service
        self.coordinator = coordinator

        start()
    }

    func backButtonTapped() {
        coordinator?.goBack()
    }

    func save() {
        recalculateValues()
        let result = service.saveTransaction(price: price, quantity: quantity, operation: selectedTab, assetId: assetId)

        if result {
            coordinator?.goBack()
        }
    }

    func update(quantity: Double) {
        self.quantity = quantity
        currentFocusedField = .quantity
        recalculateValues()
    }

    func update(price: Double) {
        self.price = price
        currentFocusedField = .price
        recalculateValues()
    }

    func update(totalSpent: Double) {
        self.totalSpent = totalSpent
        currentFocusedField = .totalSpent
        recalculateValues()
    }
}

private extension AddTransactionViewModel {
    func start() {
        service
            .subscribeToFullAsset(by: assetId)
            .map { model in
                return State.loaded(model)
            }
            .assign(to: \.asset, on: self)
            .store(in: &cancellable)
    }

    func recalculateValues() {
        switch (currentFocusedField, previousFocusedField) {
        case (.quantity, .price), (.price, .quantity):
            if quantity > 0, price > 0 {
                self.totalSpent = quantity * price
            }
        case (.totalSpent, .price), (.price, .totalSpent):
            if totalSpent > 0, price > 0 {
                self.quantity = totalSpent / price
            }

        case (.totalSpent, .quantity), (.quantity, .totalSpent):
            if totalSpent > 0, quantity > 0 {
                self.price = totalSpent / quantity
            }
        default:
            break
        }
    }
}
