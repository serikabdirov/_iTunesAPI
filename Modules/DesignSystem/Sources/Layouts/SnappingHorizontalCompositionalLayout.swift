//
//  SnappingHorizontalCompositionalLayout.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 29.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public final class SnappingHorizontalCompositionalLayout: UICollectionViewCompositionalLayout {
    override public func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        let proposedContentOffset = super.targetContentOffset(
            forProposedContentOffset: proposedContentOffset,
            withScrollingVelocity: velocity
        )

        guard let collectionView = collectionView else {
            return proposedContentOffset
        }

        switch configuration.scrollDirection {
        case .horizontal:
            let targetRect = CGRect(
                x: proposedContentOffset.x,
                y: proposedContentOffset.y,
                width: collectionView.bounds.size.width,
                height: collectionView.bounds.size.height
            )
            let layoutAttributes = (layoutAttributesForElements(in: targetRect) ?? [])
                .lazy
                .filter { $0.representedElementCategory == .cell }
                .filter { attributes in
                    // threshold to avoid animation glitch with short and fast swipe
                    abs(velocity.x) < 0.3 ||
                        (velocity.x > 0 && attributes.frame.minX > collectionView.contentOffset.x) ||
                        (velocity.x < 0 && attributes.frame.minX < collectionView.contentOffset.x)
                }
            let closestItemAttributes = layoutAttributes.min { first, second in
                abs(first.frame.minX - proposedContentOffset.x) <
                    abs(second.frame.minX - proposedContentOffset.x)
            }
            guard let closestOffsetX = closestItemAttributes?.frame.minX else {
                return proposedContentOffset
            }
            return CGPoint(x: closestOffsetX - collectionView.adjustedContentInset.left, y: proposedContentOffset.y)
        case .vertical:
            return proposedContentOffset
        @unknown default:
            return proposedContentOffset
        }
    }
}
