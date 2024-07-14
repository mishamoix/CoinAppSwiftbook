//
//  Asset.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import CoreData

@objc(Asset)
final class Asset: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var symbol: String
    @NSManaged var name: String
    @NSManaged var image: URL?
    @NSManaged var currentPrice: Double

    @NSManaged var avgPrice: Double
    @NSManaged var count: Double

    @NSManaged var sort: Int
}

extension Asset {
    var toModel: AssetModel {
        let quantity: AssetModel.Quantity?
        if avgPrice != 0, count != 0 {
            quantity = .init(avgPrice: avgPrice, count: count)
        } else {
            quantity = nil
        }

        return AssetModel(coin: CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice), sort: sort, quantity: quantity)
    }

    func update(sort: Int, coin: CoinModel) {
        self.id = coin.id
        self.symbol = coin.symbol
        self.name = coin.name
        self.image = coin.image
        self.currentPrice = coin.currentPrice
        self.sort = sort
    }
}

extension CoinModel {
    func toAsset(sort: Int, previous asset: AssetModel?) -> AssetModel {
        return AssetModel(coin: self, sort: sort, quantity: asset?.quantity)
    }
}
