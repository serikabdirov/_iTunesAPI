//
//  ShouldLoadMoreProvider.swift
//  Core
//
//  Created by Денис Кожухарь on 23.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public protocol ShouldLoadMoreProvider {
    func shouldLoadMore(_ scrollView: UIScrollView) -> Bool
}

public class ShouldLoadMoreProviderOffset: ShouldLoadMoreProvider {
    var lastContentOffset: CGPoint
    let triggerOffset: CGFloat
    let isHorizontal: Bool

    init(triggerOffset: CGFloat, isHorizontal: Bool) {
        self.lastContentOffset = .zero
        self.triggerOffset = triggerOffset
        self.isHorizontal = isHorizontal
    }

    public func shouldLoadMore(_ scrollView: UIScrollView) -> Bool {
        defer { lastContentOffset = scrollView.contentOffset }
        let lastContentOffsetValue = isHorizontal ? lastContentOffset.x : lastContentOffset.y
        let contentOffsetValue = isHorizontal ? scrollView.contentOffset.x : scrollView.contentOffset.y
        guard lastContentOffsetValue <= contentOffsetValue else { return false }
        let contentSize = isHorizontal ? scrollView.contentSize.width : scrollView.contentSize.height
        let boundsHeight = isHorizontal ?
            scrollView.bounds.width - scrollView.adjustedContentInset.left :
            scrollView.bounds.height - scrollView.adjustedContentInset.bottom
        return (contentSize - boundsHeight - contentOffsetValue) < triggerOffset
    }
}

public extension ShouldLoadMoreProvider where Self == ShouldLoadMoreProviderOffset {
    static func verticalOffset(_ triggerOffset: CGFloat) -> Self {
        Self(triggerOffset: triggerOffset, isHorizontal: false)
    }

    static func horizontalOffset(_ triggerOffset: CGFloat) -> Self {
        Self(triggerOffset: triggerOffset, isHorizontal: true)
    }
}
