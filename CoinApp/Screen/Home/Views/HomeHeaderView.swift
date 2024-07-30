//
//  HomeHeaderView.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI

struct HomeHeaderView: View {
    let model: CommonPnLModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(CurrencyFormatter.shared.price(for: model.value))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
            }
            HStack {
                Text(CurrencyFormatter.shared.percent(for: model.percent))
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.green)
                    .padding(5)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(4)
                Text(CurrencyFormatter.shared.price(for: model.pnlValue))
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.green)
                Spacer()
                Text(additionalText)
                    .font(.system(size: 24))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
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

}
