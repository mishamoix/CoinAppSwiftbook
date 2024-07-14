//
//  HomeCoinsList.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI
import Kingfisher

struct HomeCoinsList: View {

    let assetModels: [AssetModel]

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
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .frame(height: 24)

        Divider()
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

        ForEach(assetModels) { model in
            AssetView(model: model)
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
                                .font(.headline)
                                .foregroundColor(.black)

                            Text(CurrencyFormatter.shared.currency(for: 0.004, sign: model.coin.symbol))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)

                    Text(CurrencyFormatter.shared.price(for: model.coin.currentPrice))
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width * 0.25)

                    VStack(alignment: .trailing, spacing: 8) {
                        Text(CurrencyFormatter.shared.price(for: model.value))
                            .font(.subheadline)
                            .foregroundColor(color)

                        Text(CurrencyFormatter.shared.percent(for: model.percent))
                            .font(.subheadline)
                            .foregroundColor(color)
                    }
                    .frame(width: geometry.size.width * 0.25, alignment: .trailing)
                }

                Spacer()
            }
        })
        .frame(height: 60)
    }

    var color: Color {
        switch model.pl {
        case .up:
            return .green
        case .down:
            return .red
        case .same:
            return .gray
        }
    }
}
