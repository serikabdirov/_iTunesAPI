//
//  InsetLabel.swift
//
//  Created by Денис Кожухарь on 09.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

open class InsetLabel: UILabel {
    // MARK: - Public properties

    public var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    // MARK: - Overrides

    override open var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (textInsets.right + textInsets.left)
        }
    }

    override open var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }

    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
