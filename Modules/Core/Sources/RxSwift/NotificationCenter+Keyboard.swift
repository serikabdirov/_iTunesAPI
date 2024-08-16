//
//  NotificationCenter+Keyboard.swift
//
//  Created by Денис Кожухарь on 12.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public extension Reactive where Base == NotificationCenter {
    func keyboardWillShow() -> Driver<CGRect> {
        notification(UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .asDriver(onErrorJustReturn: .zero)
    }

    func keyboardWillHide() -> Driver<Void> {
        notification(UIResponder.keyboardWillHideNotification)
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
    }

    func keyboardWillChangeFrame() -> Driver<CGRect> {
        notification(UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .asDriver(onErrorJustReturn: .zero)
    }
}
