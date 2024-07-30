//
//  AddTransactionView.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import SwiftUI
import Kingfisher

struct AddTransactionView: View {

    @ObservedObject var viewModel: AddTransactionViewModel

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
                    TransactionDetails(coin: model.asset.coin, viewModel: viewModel)
                        .padding()
                }
                MainButton(title: "Добавить") {
                    viewModel.save()
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

private struct TransactionDetails: View {
    let coin: CoinModel
    @ObservedObject var viewModel: AddTransactionViewModel

    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedTab) {
                Text("Купля").tag(TransactionModel.Operation.buy)
                Text("Продажа").tag(TransactionModel.Operation.sell)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)

            ValueInput(title: "Количество", subtitle: coin.symbol.uppercased(), value: $viewModel.quantity) { value in
                viewModel.update(quantity: value)
            }

            ValueInput(title: "Цена", subtitle: "USD", value: $viewModel.price) { value in
                viewModel.update(price: value)
            }

            ValueInput(title: "Всего потрачено", subtitle: "USD", value: $viewModel.totalSpent) { value in
                viewModel.update(totalSpent: value)
            }

            Spacer()
        }
    }
}

private struct ValueInput: View {

    let title: String
    let subtitle: String
    @Binding var value: Double
    var onUpdate: (Double) -> Void


    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.gray)
            HStack {
                TextField("", value: Binding(get: {
                    return value
                }, set: { value in
                    onUpdate(value)
                }), formatter: numberFormatter)
                .padding(10)
                    .keyboardType(.decimalPad)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .textFieldStyle(PlainTextFieldStyle())

                Text(subtitle)
                    .padding(.leading, 5)
                    .foregroundColor(.gray)
            }

        }
        .padding(.vertical)
    }

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

