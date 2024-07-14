//
//  DatabaseSetup.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import Foundation
import CoreStore

final class DatabaseSetup {
    let dataStack = DataStack(xcodeModelName: "CoinKeeper", bundle: Bundle.main)

    func setup() {
        do {
            let result = try dataStack.addStorageAndWait(
                SQLiteStore(
                    fileName: "MainDatabase.sqlite",
                    localStorageOptions: .recreateStoreOnModelMismatch
                )
            )

            print(result)
        } catch {
            print(error)
        }
    }
}
