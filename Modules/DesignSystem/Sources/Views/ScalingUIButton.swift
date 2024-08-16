//
//  ScalingUIButton.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 25.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

open class ScalingUIButton: UIButton, ScalingHighlightedViewProtocol {
    override public var isHighlighted: Bool {
        didSet { handleHighlightedStateChange() }
    }
}
