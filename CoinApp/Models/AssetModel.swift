//
//  AssetModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

struct AssetModel: Identifiable {

    var id: String {
        coin.id
    }

    let coin: CoinModel
    /// добавить транзакции
}
