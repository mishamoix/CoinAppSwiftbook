//
//  UIView+Constraints
//
//
//  Created by mike on 08/09/2024.
//

import UIKit

public extension UIView {
    func insetConstraints(top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        guard let superview = self.superview else {
            print("Error: View must be added to a superview before calling insetConstraints")
            return
        }

        var constraints: [NSLayoutConstraint] = []

        if let top = top {
            constraints.append(self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top))
        }

        if let bottom = bottom {
            constraints.append(self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom))
        }

        if let left = left {
            constraints.append(self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left))
        }

        if let right = right {
            constraints.append(self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right))
        }

        NSLayoutConstraint.activate(constraints)
    }

    func insetConstraints(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        guard let superview = self.superview else {
            print("Error: View must be added to a superview before calling insetConstraints")
            return
        }

        var constraints: [NSLayoutConstraint] = []

        if let horizontal = horizontal {
            constraints.append(contentsOf: [
                self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: horizontal),
                self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -horizontal)
            ])
        }

        if let vertical = vertical {
            constraints.append(contentsOf: [
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: vertical),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -vertical)
            ])
        }

        NSLayoutConstraint.activate(constraints)
    }
}
