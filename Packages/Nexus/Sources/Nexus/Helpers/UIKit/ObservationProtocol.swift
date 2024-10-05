//
//  ObservationProtocol.swift
//
//
//  Created by mike on 08/09/2024.
//

import Foundation


@objc public protocol NObserver {
    @objc func styleDidChange()
}

@objc public protocol NObservable {
    func add(observer: NObserver)
    func remove(observer: NObserver)
}
