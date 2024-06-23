//
//  State.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

enum State<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error?)

    var canLoad: Bool {
        switch self {
        case .idle, .loaded, .error:
            return true
        case .loading:
            return false
        }
    }
}
