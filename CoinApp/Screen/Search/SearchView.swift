//
//  SearchView.swift
//  CoinApp
//
//  Created by mike on 14.07.2024.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button(action: {
                    viewModel.backTapped()
                }, label: {
                    Image(.back)
                        .resizable()
                        .frame(width: 26, height: 26)

                })
                .frame(width: 44, height: 44)
                .padding(.leading, 8)
                searchField
            }
            Spacer()

            if case let .loaded(models) = viewModel.state {
                ScrollView {
                    ForEach(models) { model in
                        CoinView(model: model)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
    }

    private var searchField: some View {
        TextField("Поиск монет", text: $viewModel.searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)
    }
}

struct CoinView: View {
    let model: AssetModel

    var body: some View {
        HStack {
            // Circle icon
            KFImage(model.coin.image)
                .resizable()
                .transition(.opacity)
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            // Coin name
            Text(model.coin.name)
                .font(.headline) // Bold text style
                .foregroundColor(.black)

            Spacer()

            // Coin price
            Text(CurrencyFormatter.shared.price(for: model.coin.currentPrice))
                .font(.headline) // Bold text style
                .foregroundColor(.black)
        }
    }
}
