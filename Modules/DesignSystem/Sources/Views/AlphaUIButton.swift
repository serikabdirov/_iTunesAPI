//
//  AlphaUIButton.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 19.01.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import UIKit

open class AlphaUIButton: UIButton, AlphaHighlightedViewProtocol {
    override public var isHighlighted: Bool {
        didSet { handleHighlightedStateChange() }
    }
}
