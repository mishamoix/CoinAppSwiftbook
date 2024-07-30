//
//  TransactionModel.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation

struct TransactionModel: Identifiable {
    enum Operation: String {
        case buy
        case sell
    }

    let id: String
    let coinId: String
    let operation: Operation
    let quantity: Double
    let price: Double
    let date: TimeInterval

    var value: Double {
        quantity * price
    }
}
