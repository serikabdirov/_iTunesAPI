//
//  TouchCancellingScrollView.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 11.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

/// UIScrollView subclass allowing to set view classes
/// which gestures should be interrupted to start scrolling
public class TouchCancellingScrollView: UIScrollView {
    // MARK: - Public properties

    /// View classes which gestures should be interrupted to start scrolling
    public var touchCancellingClasses: [UIView.Type] = [UIControl.self]

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        delaysContentTouches = false
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        delaysContentTouches = false
    }

    // MARK: - Overrides

    override public func touchesShouldCancel(in view: UIView) -> Bool {
        if touchCancellingClasses.contains(where: { view.isKind(of: $0) }) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}

/// UITableView subclass allowing to set view classes
/// which gestures should be interrupted to start scrolling
public class TouchCancellingTableView: UITableView {
    // MARK: - Public properties

    /// View classes which gestures should be interrupted to start scrolling
    public var touchCancellingClasses: [UIView.Type] = [UIControl.self]

    // MARK: - Init

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delaysContentTouches = false
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        delaysContentTouches = false
    }

    // MARK: - Overrides

    override public func touchesShouldCancel(in view: UIView) -> Bool {
        if touchCancellingClasses.contains(where: { view.isKind(of: $0) }) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }
}

/// UICollectionView subclass allowing to set view classes
/// which gestures should be interrupted to start scrolling
public class TouchCancellingCollectionView: UICollectionView {
    // MARK: - Public properties

    /// View classes which gestures should be interrupted to start scrolling
    public var touchCancellingClasses: [UIView.Type] = [UIControl.self]

    // MARK: - Init

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delaysContentTouches = false
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        delaysContentTouches = false
    }

    // MARK: - Overrides

    override public func touchesShouldCancel(in view: UIView) -> Bool {
        if touchCancellingClasses.contains(where: { view.isKind(of: $0) }) {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }
}
