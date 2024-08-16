//
//  UIStackView+Extensions.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 09.01.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import UIKit

public extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        self.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
