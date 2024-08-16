//
//  MainTabBarControllerFactory.swift
//
//  Created by Денис Кожухарь on 10.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import RouteComposer
import DesignSystem
import UIKit

final class MainTabBarControllerFactory: Factory {
    typealias Context = Any?
    typealias ViewController = MainTabBarViewController

    func build(with context: Context) throws -> ViewController {
        let vc = MainTabBarViewController()
        vc.viewControllers = buildViewControllers()
        return vc
    }

    // MARK: - Private methods

    private func buildViewControllers() -> [UIViewController] {
        MainTabBarIndex.default.compactMap { index in
            switch index {
            case .first:
                return buildTabViewController(
                    root: try? TestViewControllerFactory().build(),
                    title: "First",
                    image: UIImage(),
                    selectedImage: UIImage()
                )
            case .second:
                return buildTabViewController(
                    root: try? TestViewControllerFactory().build(),
                    title: "Second",
                    image: UIImage(),
                    selectedImage: UIImage()
                )
            }
        }
    }

    private func buildTabViewController(
        root: UIViewController?,
        title: String,
        image: UIImage,
        selectedImage: UIImage
    ) -> UIViewController? {
        guard let viewController = root else { return nil }
        let navVC = NavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        navVC.tabBarItem = tabBarItem
        return navVC
    }
}
