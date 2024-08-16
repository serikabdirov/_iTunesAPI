//
//  CustomViewViewController.swift
//
//  Created by Денис Кожухарь on 25.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public protocol CustomViewViewController: UIViewController {
    associatedtype ViewType: UIView

    // swiftlint:disable:next identifier_name
    var v: ViewType { get }
}

public extension CustomViewViewController {
    // swiftlint:disable:next identifier_name force_cast
    var v: ViewType { view as! ViewType }
}
