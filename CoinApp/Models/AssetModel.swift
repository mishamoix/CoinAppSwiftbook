//
//  AssetModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation
import SwiftUI
import Nexus

struct AssetModel: Identifiable {

    enum PL {
        case up
        case down
        case same
    }

    struct Quantity {
        let avgPrice: Double
        let count: Double
    }

    var id: String {
        coin.id
    }

    let coin: CoinModel
    let sort: Int
    let quantity: Quantity?

    var pl: PL {
        if let quantity {
            return quantity.avgPrice < coin.currentPrice ? .up : .down
        } else {
            return .same
        }
    }

    var percent: Double? {
        if let quantity {
            return (coin.currentPrice / quantity.avgPrice) - 1
        } else {
            return nil
        }
    }

    var value: Double? {
        if let quantity {
            return quantity.count * (coin.currentPrice - quantity.avgPrice)
        } else {
            return nil
        }
    }
}


extension AssetModel {
    var color: KeyPath<ColorSet, UIColor> {
        switch pl {
        case .up:
            return \.textPositive
        case .down:
            return \.textNegative
        case .same:
            return \.textSecondary
        }
    }

    var background: KeyPath<ColorSet, UIColor> {
        switch pl {
        case .up:
            return \.backgroundPositive
        case .down:
            return \.backgroundNegative
        case .same:
            return \.background
        }
    }
}
