//
//  AnyValidationRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct AnyValidationRule<Value>: ValidationRule {
    private let validationClosure: (Value) throws -> Void

    init<T: ValidationRule>(rule: T) where T.Value == Value {
        self.validationClosure = { value in
            try rule.validate(value)
        }
    }

    public func validate(_ value: Value) throws {
        try validationClosure(value)
    }
}

public extension ValidationRule {
    var asAnyRule: AnyValidationRule<Value> {
        AnyValidationRule(rule: self)
    }
}
