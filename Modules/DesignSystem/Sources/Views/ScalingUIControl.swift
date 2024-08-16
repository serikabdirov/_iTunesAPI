//
//  ScalingUIControl.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 23.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

open class ScalingUIControl: UIControl, ScalingHighlightedViewProtocol {
    override public var isHighlighted: Bool {
        didSet { handleHighlightedStateChange() }
    }
}
