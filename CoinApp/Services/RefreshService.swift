//
//  RefreshService.swift
//  CoinApp
//
//  Created by mike on 30/07/2024.
//

import Foundation

final class RefreshService {
    private var timer: Timer?

    private let assetService: AssetService

    deinit {
        timer?.invalidate()
    }

    init(assetService: AssetService) {
        self.assetService = assetService
    }

    func scheduleUpdate() {
        timer?.invalidate()

        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc
    private func update() {
        assetService.loadData()
    }
}

