//
//  CommonPnL.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation
import SwiftUI

struct CommonPnLModel {
    let value: Double
    let percent: Double
    let pnlValue: Double

    var color: Color {
        percent > 0 ? .green : .red
    }
}
