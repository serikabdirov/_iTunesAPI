//
// StartView.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import DesignSystem

final class StartView: UIView {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViews() {
        backgroundColor = .white
    }

    private func setupConstraints() {}
}
