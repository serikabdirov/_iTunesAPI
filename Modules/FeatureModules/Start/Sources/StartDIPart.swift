//
// StartDIPart.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import UIKit

public final class StartDIPart: DIPart {
    public static func load(container: DIContainer) {
        container.register(StartViewModelImpl.init(router:))
            .as(StartViewModel.self)

        container.register(StartViewController.init(viewModel:))
            .as(StartViewControllerTag.self)
            .lifetime(.objectGraph)
    }
}
