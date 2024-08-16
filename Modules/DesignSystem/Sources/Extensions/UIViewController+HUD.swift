//
//  UIViewController+HUD.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxSwift
import SVProgressHUD
import UIKit

public extension UIViewController {
    func setHUD(visible isVisible: Bool, in view: UIView? = nil) {
        if isVisible {
            showHUD(in: view)
        } else {
            hideHUD()
        }
    }

    func showHUD(in view: UIView? = nil) {
        if let view = view {
            SVProgressHUD.setContainerView(view)
        }
        SVProgressHUD.show()
    }

    func hideHUD() {
        SVProgressHUD.dismiss {
            SVProgressHUD.setContainerView(nil)
        }
    }
}

public extension Reactive where Base: UIViewController {
    var showHUD: Binder<Bool> {
        Binder<Bool>(base) { vc, isVisible in
            vc.setHUD(visible: isVisible)
        }
    }

    var showHUDInView: Binder<Bool> {
        Binder<Bool>(base) { vc, isVisible in
            vc.setHUD(visible: isVisible, in: vc.view)
        }
    }
}
