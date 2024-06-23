//
//  CoinModel.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

typealias Coins = [CoinModel]

struct CoinModel: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
}
