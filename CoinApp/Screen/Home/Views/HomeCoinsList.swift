//
//  HomeCoinsList.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI
import Kingfisher
import Nexus

struct HomeCoinsList: View {

    let assetModels: [AssetModel]
    let assetTapped: (String) -> Void

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("Название")
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)

                Text("Цена")
                    .frame(width: geometry.size.width * 0.25)

                Text("П/У")
                    .frame(width: geometry.size.width * 0.25, alignment: .trailing)
            }
            .appForeground(\.textSecondary)
            .appFont(\.headerTertiary)
        }
        .padding(.horizontal, 16)
        .frame(height: 24)

        Divider()
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

        ForEach(assetModels) { model in
            AssetView(model: model)
                .contentShape(Rectangle())
                .onTapGesture {
                    assetTapped(model.id)
                }
            Divider()
        }
        .padding(.horizontal, 16)
    }
}


struct AssetView: View {

    let model: AssetModel

    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .center) {
                Spacer()

                HStack(spacing: 0) {
                    HStack(spacing: 12) {
                        KFImage(model.coin.image)
                            .resizable()
                            .transition(.opacity)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 8) {
                            Text(model.coin.name.uppercased())
                                .appFont(\.headerSecondary)
                                .appForeground(\.text)

                            Text(CurrencyFormatter.shared.currency(for: model.quantity?.count ?? 0, sign: model.coin.symbol))
                                .appFont(\.caption)
                                .appForeground(\.textSecondary)
                        }
                    }
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)

                    Text(CurrencyFormatter.shared.price(for: model.coin.currentPrice))
                        .appFont(\.headerSecondary)
                        .appForeground(\.text)
                        .frame(width: geometry.size.width * 0.25)

                    VStack(alignment: .trailing, spacing: 8) {
                        Text(CurrencyFormatter.shared.price(for: model.value))

                        Text(CurrencyFormatter.shared.percent(for: model.percent))
                    }
                    .appFont(\.text)
                    .appForeground(model.color)
                    .frame(width: geometry.size.width * 0.25, alignment: .trailing)
                }

                Spacer()
            }
        })
        .frame(height: 60)
    }
}
