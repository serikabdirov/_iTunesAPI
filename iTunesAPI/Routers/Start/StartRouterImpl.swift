//
// StartRouterImpl.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import DITranquillity
import RouteComposer
import Start

final class StartRouterImpl {
    // MARK: - Public properties

    weak var viewController: UIViewController?

    // swiftlint:disable:next implicitly_unwrapped_optional
    var container: DIContainer!

    // MARK: - Private properties

    private lazy var router = DefaultRouter()
}

extension StartRouterImpl: StartRouter {
    func startWasShown() {
        let destination = ScreenConfigurations.mainTabBarStep()
        router.commitNavigation(to: destination)
    }
}

extension StartRouterImpl {
    static func register(in container: DIContainer) {
        container.register(StartRouterImpl.init)
            .injection(\.container)
            .injection(cycle: true, \.viewController) { $0 as StartViewControllerTag }
            .as(StartRouter.self)
    }
}
