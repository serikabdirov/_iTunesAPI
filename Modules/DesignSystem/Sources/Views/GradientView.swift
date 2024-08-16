//
//  GradientView.swift
//
//  Created by Денис Кожухарь on 17.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

open class GradientView: UIView {
    // MARK: - Public properties

    public var colors: [UIColor] {
        // swiftlint:disable:next force_cast
        get { ((gradientLayer.colors ?? []) as! [CGColor]).map(UIColor.init(cgColor:)) }
        set { gradientLayer.colors = newValue.map(\.cgColor) }
    }

    public var locations: [NSNumber] {
        get { gradientLayer.locations ?? [] }
        set { gradientLayer.locations = newValue }
    }

    public var startPoint: CGPoint {
        get { gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }

    public var endPoint: CGPoint {
        get { gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }

    public var type: CAGradientLayerType {
        get { gradientLayer.type }
        set { gradientLayer.type = newValue }
    }

    // swiftlint:disable:next force_cast
    public var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    override open class var layerClass: AnyClass { CAGradientLayer.self }
}
