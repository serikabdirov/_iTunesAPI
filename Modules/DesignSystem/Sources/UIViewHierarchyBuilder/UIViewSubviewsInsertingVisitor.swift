//
//  Created by Denis Kozhukhar on 30.12.2022.
//

import UIKit

struct UIViewSubviewsInsertingVisitor {
    let subviews: [UIView]

    func visit(view: UIView) {
        if let stackView = view as? UIStackView {
            visit(stackView: stackView)
        } else {
            defaultVisit(view)
        }
    }

    private func visit(stackView: UIStackView) {
        subviews.forEach { stackView.addArrangedSubview($0) }
    }

    private func defaultVisit(_ view: UIView) {
        subviews.forEach { view.addSubview($0) }
    }
}
