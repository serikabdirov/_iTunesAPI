//
//  UIView+ScalingHighlightedViewProtocol.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 23.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public protocol ScalingHighlightedViewProtocol: UIView {
    var scaleFactor: CGFloat { get }

    func handleHighlightedStateChange(isHighlighted: Bool, animated: Bool)
}

public extension ScalingHighlightedViewProtocol {
    var scaleFactor: CGFloat { 0.95 }

    func handleHighlightedStateChange(isHighlighted: Bool, animated: Bool = true) {
        let animations: (() -> Void) = { [self] in
            transform = isHighlighted ? CGAffineTransform(scaleX: scaleFactor, y: scaleFactor) : .identity
        }
        if animated {
            UIView.animate(
                withDuration: 0.2,
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

public extension ScalingHighlightedViewProtocol where Self: UIControl {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}

public extension ScalingHighlightedViewProtocol where Self: UICollectionViewCell {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}

public extension ScalingHighlightedViewProtocol where Self: UITableViewCell {
    func handleHighlightedStateChange(animated: Bool = true) {
        handleHighlightedStateChange(isHighlighted: isHighlighted, animated: animated)
    }
}
