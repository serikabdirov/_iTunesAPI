//
//  NotNilRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct NotNilRule<C>: ValidationRule {
    public let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    public func validate(_ value: C?) throws {
        if value == nil {
            throw ValidationError(message: errorMessage)
        }
    }
}

public extension AnyValidationRule {
    static func notNil<T>(errorMessage: String) -> Self where Self.Value == T? {
        NotNilRule<T>(errorMessage: errorMessage).asAnyRule
    }
}
