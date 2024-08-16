//
//  MainTabBarViewController.swift
//
//  Created by Денис Кожухарь on 10.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import Platform
import RouteComposer
import DesignSystem
import UIKit

enum MainTabBarIndex: Int, CaseIterable {
    case first
    case second

    static let `default`: [Self] = [.first, .second]
}

class MainTabBarViewController: UITabBarController {
    // MARK: - Private properties

    private lazy var router = DefaultRouter()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup() {
        setupAppearance()
    }

    private func setupAppearance() {
        view.backgroundColor = .white
        let tabBarItemAppearance = UITabBarItemAppearance().then { appearance in
            appearance.normal.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.gray
            ]
            appearance.selected.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.blue
            ]
        }
        tabBar.standardAppearance = UITabBarAppearance().then { appearance in
            appearance.configureWithDefaultBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.stackedLayoutAppearance = tabBarItemAppearance
            appearance.inlineLayoutAppearance = tabBarItemAppearance
            appearance.compactInlineLayoutAppearance = tabBarItemAppearance
        }
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = UITabBarAppearance().then { appearance in
                appearance.configureWithTransparentBackground()
                appearance.stackedLayoutAppearance = tabBarItemAppearance
                appearance.inlineLayoutAppearance = tabBarItemAppearance
                appearance.compactInlineLayoutAppearance = tabBarItemAppearance
            }
        }
    }
}
