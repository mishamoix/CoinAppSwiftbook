//
//  CurrencyFormatter.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import Foundation

final class CurrencyFormatter {
    static let shared = CurrencyFormatter()

    private init() {}

    private let formatterCurrency: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.currencySymbol = "$"
        fmt.numberStyle = .currency
        fmt.maximumSignificantDigits = 4
        return fmt
    }()

    private let formatterPercent: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .percent
        fmt.maximumFractionDigits = 2
        return fmt
    }()

    private let formatterNumber: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 3
        return fmt
    }()


    func price(for value: Double?, defaultValue: String = "--") -> String {
        guard let value else {
            return defaultValue
        }

        return currency(for: value, sign: "$")
    }

    func percent(for value: Double?, defaultValue: String = "--") -> String {
        guard let value else {
            return defaultValue
        }
        return formatterPercent.string(from: NSNumber(floatLiteral: value)) ?? String(value)
    }

    func currency(for value: Double, sign: String) -> String {
        formatterCurrency.currencySymbol = sign.uppercased()
        return formatterCurrency.string(from: NSNumber(floatLiteral: value)) ?? String(value)
    }

    func number(for value: Double?, defaultValue: String = "--") -> String {
        guard let value else {
            return defaultValue
        }
        return formatterNumber.string(from: NSNumber(floatLiteral: value)) ?? String(value)
    }
}
