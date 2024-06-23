//
//  CurrencyFormatter.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

final class CurrencyFormatter {
    static let shared = CurrencyFormatter()

    private let formatterCurrency: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.currencySymbol = "$"
        fmt.numberStyle = .currency
        fmt.minimumFractionDigits = 0
        return fmt
    }()

    private let formatterPercent: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .percent
        fmt.minimumFractionDigits = 0
        return fmt
    }()


    func price(for value: Double) -> String {
        return currency(for: value, sign: "$")
    }

    func percent(for value: Double) -> String {
        return formatterPercent.string(from: NSNumber(floatLiteral: value)) ?? String(value)
    }

    func currency(for value: Double, sign: String) -> String {
        formatterCurrency.currencySymbol = sign.uppercased()
        return formatterCurrency.string(from: NSNumber(floatLiteral: value)) ?? String(value)
    }
}
