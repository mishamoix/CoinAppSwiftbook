//
//  HomeHeaderView.swift
//  CoinApp
//
//  Created by mike on 23.06.2024.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("$9999")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
            }
            HStack {
                Text("1.55%")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.green)
                    .padding(5)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(4)
                Text("153$")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.green)
                Spacer()
                Text("🚀🚀")
                    .font(.system(size: 24))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        .padding()
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
