//
//  UIButton+Spacing.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 25.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public extension UIButton {
    func setImageTitleSpacing(
        _ spacing: CGFloat,
        withContentInsets contentInsets: UIEdgeInsets
    ) {
        if semanticContentAttribute == .forceRightToLeft {
            contentEdgeInsets = UIEdgeInsets(
                top: contentInsets.top,
                left: contentInsets.left + spacing,
                bottom: contentInsets.bottom,
                right: contentInsets.right
            )

            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -spacing,
                bottom: 0,
                right: spacing
            )
        } else {
            contentEdgeInsets = UIEdgeInsets(
                top: contentInsets.top,
                left: contentInsets.left,
                bottom: contentInsets.bottom,
                right: contentInsets.right + spacing
            )

            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: spacing,
                bottom: 0,
                right: -spacing
            )
        }
    }
}
