//
//  HomeView.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI
import Nexus

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            switch viewModel.state {
            case .idle, .loading:
                loader
            case .loaded(let models):
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.searchTapped()
                    }, label: {
                        Image(.magnifier)
                            .resizable()
                            .renderingMode(.template)
                            .appForeground(\.text)
                            .frame(width: 26, height: 26)
                            .frame(width: 44, height: 44)
                    })
                    .padding(.trailing, 8)
                }.frame(height: 44)
                ScrollView {
                    if let pnl = viewModel.commonPnL {
                        HomeHeaderView(model: pnl)
                            .padding(.bottom, 20)
                    }
                    makeList(with: models)
                }
            case .error:
                error
            }

            Button("Сменить тему") {
                if themeManager.theme.name == "Blue" {
                    themeManager.updateTheme(YellowTheme)
                } else {
                    themeManager.updateTheme(BlueTheme)
                }
            }
            .buttonStyle(ActionButtonStyle(style: .affirm))
            .padding(.horizontal)
        }
        .appBackground(\.background)
    }
}

private extension HomeView {

    var loader: some View {
        return ProgressView()
            .progressViewStyle(.automatic)
            .scaleEffect(2) // Adjust the scale as needed

    }

    var error: some View {
        HStack {
            Text("Упс, ошибка")
                .foregroundStyle(.red)

            Button("Перезагрузить") {
                viewModel.reload()
            }
            .buttonStyle(.bordered)
            .padding(.vertical, 16)
        }
    }

    func makeList(with models: [AssetModel]) -> some View {
        return HomeCoinsList(assetModels: models) { assetId in
            viewModel.assetTapped(with: assetId)
        }
    }
}
