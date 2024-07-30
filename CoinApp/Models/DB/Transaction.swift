//
//  Transaction.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import CoreData

@objc(Transaction)
final class Transaction: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var coinId: String

    @NSManaged var operation: String
    @NSManaged var quantity: Double
    @NSManaged var price: Double
    @NSManaged var date: TimeInterval
}

extension Transaction {
    var toModel: TransactionModel {
        return TransactionModel(
            id: id,
            coinId: coinId,
            operation: TransactionModel.Operation(rawValue: operation) ?? .buy,
            quantity: quantity,
            price: price,
            date: date
        )
    }

    func update(transaction: TransactionModel) {
        self.id = transaction.id
        self.coinId = transaction.coinId
        self.date = transaction.date
        self.operation = transaction.operation.rawValue
        self.quantity = transaction.quantity
        self.price = transaction.price
    }
}
