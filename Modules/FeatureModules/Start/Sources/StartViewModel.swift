//
// StartViewModel.swift
//
// Created by Denis Kozhukhar.
// Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import Foundation
import Platform

protocol StartViewModel: AnyObject {
    func viewDidAppear()
}

final class StartViewModelImpl: StartViewModel {
    // MARK: - Private properties

    private let router: StartRouter

    // MARK: - Init

    init(router: StartRouter) {
        self.router = router
    }

    // MARK: - StartViewModel

    func viewDidAppear() {
        router.startWasShown()
    }
}
