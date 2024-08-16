//
//  Shadows.swift
//
//  Created by Денис Кожухарь on 11.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public struct ShadowStyle: Equatable {
    let shadowPath: UIBezierPath?
    let shadowColor: UIColor?
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: Float

    public init(
        shadowPath: UIBezierPath? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize = .zero,
        shadowRadius: CGFloat = 0,
        shadowOpacity: Float = 1
    ) {
        self.shadowPath = shadowPath
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
}

public extension UIView {
    func apply(shadowStyle: ShadowStyle?) {
        layer.shadowPath = shadowStyle?.shadowPath?.cgPath
        layer.shadowColor = shadowStyle?.shadowColor?.cgColor
        layer.shadowOffset = shadowStyle?.shadowOffset ?? .zero
        layer.shadowRadius = shadowStyle?.shadowRadius ?? .zero
        layer.shadowOpacity = shadowStyle?.shadowOpacity ?? .zero
    }
}
