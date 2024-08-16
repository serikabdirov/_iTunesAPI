//
//  UIView+AlphaHighlightedViewProtocol.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 19.01.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import UIKit

public protocol AlphaHighlightedViewProtocol: UIView {
    var highlightedAlpha: CGFloat { get }

    func handleHighlightedStateChange(isHighlighted: Bool, animated: Bool)
}

public extension AlphaHighlightedViewProtocol {
    var highlightedAlpha: CGFloat { 0.6 }

    func handleHighlightedStateChange(isHighlighted: Bool, animated: Bool = true) {
        let animations: (() -> Void) = { [self] in
            alpha = isHighlighted ? highlightedAlpha : 1
        }
        if animated {
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: [.beginFromCurrentState, .curveEaseInOut, .allowUserInteraction],
                animations: animations,
                completion: nil
            )
        } else {
            animations()
        }
    }
}

public extension AlphaHighlightedViewProtocol where Self: UIControl {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}

public extension AlphaHighlightedViewProtocol where Self: UICollectionViewCell {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}

public extension AlphaHighlightedViewProtocol where Self: UITableViewCell {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}
