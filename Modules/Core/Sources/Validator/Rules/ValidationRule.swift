//
//  ValidationRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public protocol ValidationRule {
    associatedtype Value

    func validate(_ value: Value) throws
}
