//
//  HomeViewModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var state: State<[AssetModel]> = .idle
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
                case let .fetched(data, _):
                    return .loaded(data)
                case .error(let error):
                    return .error(error)
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
}
