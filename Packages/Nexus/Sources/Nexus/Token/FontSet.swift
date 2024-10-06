//
//  FontSet.swift
//  DesignSystem
//
//  Created by mike on 18/08/2024.
//

import UIKit

public protocol FontSet {
    var header: UIFont { get }
    var headerSecondary: UIFont { get }
    var headerTertiary:UIFont { get }

    var text: UIFont { get }
    var caption: UIFont { get }

    var button: UIFont { get }
}

