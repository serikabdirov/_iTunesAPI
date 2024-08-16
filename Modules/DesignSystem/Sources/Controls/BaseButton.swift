//
//  BaseButton.swift
//
//  Created by Марина Айбулатова on 08.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import SnapKit

public final class BaseButton: UIControl {
    // MARK: - Public properties

    public var text: String? {
        didSet { updateText() }
    }

    public var contentInsets: UIEdgeInsets = .zero {
        didSet { updateContentInsets() }
    }

    public var height: CGFloat? {
        didSet { updateHeight() }
    }

    public var backgroundColors: [UIControl.State: UIColor] = [:] {
        didSet { updateBackgroundAppearance() }
    }

    public var borderColors: [UIControl.State: UIColor] = [:] {
        didSet { updateBorderAppearance() }
    }

    public var textColors: [UIControl.State: UIColor] = [:] {
        didSet { updateTextAppearance() }
    }

    public var cornerRadius: CGFloat = 0 {
        didSet { updateBorderAppearance() }
    }

    public var borderWidths: [UIControl.State: CGFloat] = [:] {
        didSet { updateBorderAppearance() }
    }

    public var font: UIFont = .systemFont(ofSize: 14) {
        didSet { updateTextAppearance() }
    }

    // MARK: - Override properties

    override public var isEnabled: Bool {
        didSet { updateAppearance() }
    }

    override public var isHighlighted: Bool {
        didSet { updateAppearance() }
    }

    override public var isSelected: Bool {
        didSet { updateAppearance() }
    }

    // MARK: - Override methods

    override public func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        backgroundLayer.frame = bounds
        CATransaction.commit()
        textLabel.preferredMaxLayoutWidth = bounds.width - contentInsets.left - contentInsets.right
    }

    // MARK: - Private properties

    // swiftlint:disable implicitly_unwrapped_optional
    private var textLabel: UILabel!
    private var backgroundLayer: CALayer!

    private var contentLayoutGuide: UILayoutGuide!
    private var heightConstraint: Constraint!
    // swiftlint:enable implicitly_unwrapped_optional

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        configureViews()
        configureConstraints()
        updateAppearance()
        updateText()
    }

    // MARK: - Private methods

    private func configureViews() {
        textLabel = {
            let i = UILabel()
            i.numberOfLines = 0
            i.textAlignment = .center
            i.font = font
            return i
        }()

        backgroundLayer = {
            let i = CALayer()
            i.zPosition = -100
            return i
        }()

        layer.insertSublayer(backgroundLayer, at: 0)
        addSubview(textLabel)
    }

    private func configureConstraints() {
        contentLayoutGuide = UILayoutGuide()
        addLayoutGuide(contentLayoutGuide)
        updateContentInsets()

        textLabel.snp.updateConstraints { update in
            update.edges.equalTo(contentLayoutGuide)
        }

        snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(56).constraint
            heightConstraint.isActive = false
        }

        updateHeight()
    }

    // MARK: - Update methods

    private func updateContentInsets() {
        contentLayoutGuide.snp.updateConstraints { update in
            update.edges.equalTo(contentInsets)
        }
    }

    private func updateHeight() {
        if let height = height {
            heightConstraint.update(offset: height)
            heightConstraint.isActive = true
        } else {
            heightConstraint.isActive = false
        }
    }

    private func updateText() {
        textLabel.text = text
        textLabel.isHidden = textLabel.text.orEmpty.isEmpty
    }

    private func updateAppearance() {
        updateBackgroundAppearance()
        updateBorderAppearance()
        updateTextAppearance()
    }

    private func updateBackgroundAppearance() {
        backgroundLayer.backgroundColor = backgroundColors.value(for: state)?.cgColor
    }

    private func updateTextAppearance() {
        textLabel.font = font
        textLabel.textColor = textColors.value(for: state)
    }

    private func updateBorderAppearance() {
        backgroundLayer.cornerRadius = cornerRadius
        backgroundLayer.borderColor = borderColors.value(for: state)?.cgColor
        backgroundLayer.borderWidth = borderWidths.value(for: state) ?? 0
    }
}

extension Dictionary where Key == UIControl.State {
    func value(for state: UIControl.State) -> Value? {
        let key = keys
            .filter { $0.isSubset(of: state) }
            .max { $0.rawValue.nonzeroBitCount < $1.rawValue.nonzeroBitCount }
        return key.flatMap { self[$0] }
    }
}

extension UIControl.State: Hashable {}
