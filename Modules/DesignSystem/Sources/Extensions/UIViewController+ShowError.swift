//
//  UIViewController+ShowError.swift
//
//  Created by Денис Кожухарь on 31.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import R
import RxSwift
import UIKit

public extension UIViewController {
    func showError(title: String = RStrings.Shared.error, message: String) {
        // Workaround for case, when view controller already not in hierarchy,
        // but api or some other error callback/subscription called
        // before view controller deinitialized
        guard isViewLoaded, view.window != nil else { return }

        showAlert(
            title: title,
            message: message,
            animated: true,
            preferredStyle: .alert,
            actions: [
                UIAlertAction(title: RStrings.Shared.ok, style: .cancel)
            ],
            tintColor: .blue
        )
    }
}

public extension Reactive where Base: UIViewController {
    var showError: Binder<String> {
        Binder<String>(base) { vc, message in
            vc.showError(message: message)
        }
    }
}
