//
//  TransactionDatabaseProvider.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import CoreStore
import Combine

protocol TransactionDatabaseProvidable {
    func subscribeForTransactions(with coinId: String) -> AnyPublisher<[TransactionModel], Never>

    func add(transaction model: TransactionModel)
    func fetchTransactions(by coinId: String) -> [TransactionModel]?
}

final class TransactionDatabaseProvider {
    private let dataStack: DataStack

    init(dataStack: DataStack) {
        self.dataStack = dataStack
    }
}

extension TransactionDatabaseProvider: TransactionDatabaseProvidable {
    func subscribeForTransactions(with coinId: String) -> AnyPublisher<[TransactionModel], Never> {
        dataStack.publishList(
            From<Transaction>()
                .where(\.coinId == coinId)
                .orderBy(.descending(\.date))
        )
        .reactive
        .snapshot(emitInitialValue: true)
        .map { snapshot in
            snapshot
                .compactMap(\.object)
                .map(\.toModel)
        }
        .eraseToAnyPublisher()
    }

    func add(transaction model: TransactionModel) {
        try? dataStack.perform { transaction in
            let new = transaction.create(Into<Transaction>())
            new.update(transaction: model)
        }
    }

    func fetchTransactions(by coinId: String) -> [TransactionModel]? {
        return try? dataStack.fetchAll(From<Transaction>()
            .where(\.coinId == coinId))
        .map(\.toModel)
    }
}
