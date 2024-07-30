//
//  MainButton.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI

struct MainButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(12)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
        }
        .padding()
    }
}

#Preview {
    MainButton(title: "Новая транзакция", action: {
        print("привет")
    })
}
