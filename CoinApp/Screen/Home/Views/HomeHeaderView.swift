//
//  HomeHeaderView.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI
import Nexus

struct HomeHeaderView: View {
    let model: CommonPnLModel
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(CurrencyFormatter.shared.price(for: model.value))
                    .appFont(\.header)
                    .appForeground(\.text)
            }
            HStack {
                Text(CurrencyFormatter.shared.percent(for: model.percent))
                    .appForeground(profitText)
                    .padding(5)
                    .appBackground(model.percent > 0 ? \.backgroundPositive : \.backgroundNegative)
                    .cornerRadius(4)
                Text(CurrencyFormatter.shared.price(for: model.pnlValue))
                    .font(.system(size: 18, weight: .medium))
                    .appForeground(profitText)
                Spacer()
                Text(additionalText)
            }
            .appFont(\.text)

        }
        .padding()
        .appBackground(\.backgroundSecondary)
        .cornerRadius(12)
        .shadow(color: Color(themeManager.colors.shadow), radius: 10, x: 0, y: 4)
        .padding()
    }

    private var additionalText: String {
        switch model.percent {
        case 0...0.1:
            return "👌"
        case 0.1...1:
            return "🚀"
        case 1...2:
            return "🚀🚀"
        case 2...:
            return "🚀🚀🚀"
        case -0.1...0:
            return "😢"
        case -1...(-0.1):
            return "👎"
        case -2...(-1):
            return "💀"
        case ...(-2):
            return "💀💀💀"
        default:
            return "☺️"
        }
    }

    private var profitText: KeyPath<ColorSet, UIColor> {
        if model.percent > 0 {
            return \.textPositive
        } else {
            return \.textNegative
        }
    }
}
