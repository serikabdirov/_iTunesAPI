//
//  BoolRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct BoolRule: ValidationRule {
    public let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    public func validate(_ value: Bool?) throws {
        if !(value ?? false) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public extension AnyValidationRule where Value == BoolRule.Value {
    static func bool(errorMessage: String) -> Self { BoolRule(errorMessage: errorMessage).asAnyRule }
}
