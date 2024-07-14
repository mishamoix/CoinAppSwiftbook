//
//  SearchViewModel.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var state: State<[AssetModel]> = .idle
    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: MainCoordinatorProtocol?
    private let service: AssetServiceProtocol


    init(service: AssetServiceProtocol, coordinator: MainCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator

        setup()
    }

    func backTapped() {
        coordinator?.goBack()
    }

    func assetTapped() {
        
    }
}

private extension SearchViewModel {

    func setup() {

        func filter(assets: [AssetModel], text: String) -> [AssetModel] {
            print("filter data")
            let searchText = text.normalized

            if searchText.isEmpty {
                return assets
            }

            let result = assets.filter({ $0.coin.symbol.normalized.contains(searchText) || $0.coin.name.normalized.contains(searchText) })

            return result
        }

        Publishers.CombineLatest(
            service.assets,
            $searchText.debounce(for: 0.3, scheduler: RunLoop.main)
        )
        .sink { [weak self] (state, text) in
            guard let self else { return }
            switch state {
            case .idle:
                self.state = .idle
            case .fetching:
                self.state = .loading
            case .fetched(let data, _):
                self.state = .loaded(filter(assets: data, text: text))
            case .error(let error):
                self.state = .error(error)
            }
        }
        .store(in: &cancellables)
    }
}

extension String {
    var normalized: String {
        self.lowercased()
            .replacingOccurrences(of: " ", with: "")
    }
}

