//
// StartViewController.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import DesignSystem

public protocol StartViewControllerTag: UIViewController {}

final class StartViewController: UIViewController, StartViewControllerTag, CustomViewViewController {
    typealias ViewType = StartView

    // MARK: - Private properties

    private let viewModel: StartViewModel

    // MARK: - Init

    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        let view = StartView()
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
}
