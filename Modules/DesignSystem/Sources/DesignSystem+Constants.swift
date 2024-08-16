//
//  DesignSystem+Constants.swift
//
//  Created by Денис Кожухарь on 11.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

public extension DesignSystem {
    enum Constants {}
}

public extension DesignSystem.Constants {
    static let mainPadding: CGFloat = 12

    static let mainInsets = UIEdgeInsets(top: 0, left: mainPadding, bottom: 0, right: mainPadding)

    static let mainDirectionalInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: mainPadding,
        bottom: 0,
        trailing: mainPadding
    )
}
