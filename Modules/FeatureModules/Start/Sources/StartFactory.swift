//
// StartFactory.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import RouteComposer
import UIKit

public final class StartFactory: Factory {
    public typealias Context = Void

    public var container: DIContainer

    public init(container: DIContainer) {
        self.container = container
    }

    public func build(with context: Context) throws -> some UIViewController {
        container.resolve() as StartViewController
    }
}
