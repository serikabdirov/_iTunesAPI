//
//  UIViewController+Extensions.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 03.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import R
import UIKit

public extension UIViewController {
    func showAlert(
        title: String?,
        message: String?,
        animated: Bool = true,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction]
    ) {
        showAlert(
            title: title,
            message: message,
            animated: animated,
            preferredStyle: preferredStyle,
            actions: actions,
            tintColor: .blue
        )
    }

    func setContentScrollViewIfNeeded(_ scrollView: UIScrollView) {
        if #available(iOS 15.0, *) {
            setContentScrollView(scrollView)
        }
    }
}
