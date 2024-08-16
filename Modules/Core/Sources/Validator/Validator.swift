//
//  Validator.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct Validator<Value>: ValidatorType {
    public var rules: [AnyValidationRule<Value>]

    public init(rules: [AnyValidationRule<Value>]) {
        self.rules = rules
    }
}
