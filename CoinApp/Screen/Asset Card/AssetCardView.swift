//
//  AssetCardView.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import SwiftUI
import Kingfisher
import Nexus

struct AssetCardView: View {

    @ObservedObject var viewModel: AssetCardViewModel

    var body: some View {
        VStack {
            switch viewModel.asset {
            case .loading, .idle:
                header(with: nil)
                Spacer()
                ProgressView()
                    .progressViewStyle(.automatic)
                    .scaleEffect(2)
                Spacer()
            case .loaded(let model):
                header(with: model.asset)
                ScrollView {
                    PortfolioView(asset: model.asset)
                        .padding(.top, 12)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)

                    ForEach(model.transactions) { transaction in
                        TransactionView(model: transaction, coin: model.asset.coin)
                    }
                }
                MainButton(title: "Добавить транзакцию") {
                    viewModel.newTransactionTapped()
                }
            case .error:
                header(with: nil)
                Spacer()
                Text("Error!")
                Spacer()
            }
        }
    }

    func header(with asset: AssetModel?) -> some View {
        ZStack {
            HStack {
                Button(action: {
                    viewModel.backButtonTapped()
                }, label: {
                    Image(.back)
                        .resizable()
                        .frame(width: 26, height: 26)

                })
                .frame(width: 44, height: 44)
                Spacer()
            }

            if let asset {
                HStack {
                    KFImage(asset.coin.image)
                        .resizable()
                        .transition(.opacity)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    Text(asset.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

private struct PortfolioView: View {

    let asset: AssetModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(CurrencyFormatter.shared.price(for: asset.coin.currentPrice * (asset.quantity?.count ?? 0)))
                .font(.system(size: 40, weight: .bold))

            HStack(spacing: 8) {
                Text(CurrencyFormatter.shared.percent(for: asset.percent))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .appBackground(asset.background)
                    .appForeground(asset.color)
                    .cornerRadius(4)

                Text(CurrencyFormatter.shared.price(for: asset.value))
                    .appForeground(asset.color)
            }
            .font(.system(size: 14, weight: .medium))

            VStack(spacing: 12) {
                RowView(title: "Стоимость монеты", value: CurrencyFormatter.shared.price(for: asset.coin.currentPrice))
                RowView(title: "Всего вложено", value: CurrencyFormatter.shared.price(for: (asset.quantity?.count ?? 0) * (asset.quantity?.avgPrice ?? 0)))
                RowView(title: "Средняя цена", value: CurrencyFormatter.shared.price(for: asset.quantity?.avgPrice ?? 0))
                RowView(title: "Всего монет", value: CurrencyFormatter.shared.currency(for: asset.quantity?.count ?? 0, sign: asset.coin.symbol))

            }
            .padding(.top, 8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

private struct RowView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .font(.system(size: 16))
    }
}

private struct TransactionView: View {

    let model: TransactionModel
    let coin: CoinModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(color)
                    .font(.headline)
                Text("цена " + CurrencyFormatter.shared.price(for: model.price))
                    .foregroundStyle(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(quantity)
                    .foregroundStyle(color)
                    .font(.headline)
                Text(CurrencyFormatter.shared.price(for: model.value))
                    .foregroundStyle(.gray)
            }
        }.padding()
    }

    private var color: Color {
        switch model.operation {
        case .buy:
            return .green
        case .sell:
            return .red
        }
    }

    private var title: String {
        switch model.operation {
        case .buy:
            return "Покупка"
        case .sell:
            return "Продажа"
        }
    }

    private var quantity: String {
        let result = CurrencyFormatter.shared.number(for: model.quantity)
        switch model.operation {
        case .buy:
            return "+" + String(result)
        case .sell:
            return "-" + String(result)
        }
    }
}

