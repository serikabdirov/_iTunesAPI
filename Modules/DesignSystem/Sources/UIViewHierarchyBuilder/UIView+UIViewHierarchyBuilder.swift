//
//  Created by Denis Kozhukhar on 30.12.2022.
//

import UIKit

public extension UIView {
    convenience init(@UIViewHierarchyBuilder subviews: () -> [UIView]) {
        self.init(frame: .zero)
        UIViewSubviewsInsertingVisitor(subviews: subviews()).visit(view: self)
    }

    @discardableResult
    func inserting(@UIViewHierarchyBuilder subviews: () -> [UIView]) -> Self {
        UIViewSubviewsInsertingVisitor(subviews: subviews()).visit(view: self)
        return self
    }
}

public extension UIStackView {
    @discardableResult
    func inserting(axis: NSLayoutConstraint.Axis, @UIViewHierarchyBuilder subviews: () -> [UIView]) -> Self {
        self.axis = axis
        inserting(subviews: subviews)
        return self
    }
}
