//
//  AssetCardViewModel.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import Combine

final class AssetCardViewModel: ObservableObject {

    @Published private(set) var asset: State<FullAssetInfoModel> = .idle

    private var cancellable = Set<AnyCancellable>()

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

    func newTransactionTapped() {
        coordinator?.goToAddTransaction(with: assetId)
    }
}

private extension AssetCardViewModel {
    func start() {
        service
            .subscribeToFullAsset(by: assetId)
            .map { model in
                return State.loaded(model)
            }
            .assign(to: \.asset, on: self)
            .store(in: &cancellable)
    }
}
