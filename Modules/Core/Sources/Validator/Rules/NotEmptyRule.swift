//
//  NotEmptyRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct NotEmptyRule<C: Collection>: ValidationRule {
    public let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    public func validate(_ value: C) throws {
        if value.isEmpty {
            throw ValidationError(message: errorMessage)
        }
    }
}

public extension AnyValidationRule {
    static func notEmpty(errorMessage: String) -> Self
        where Self.Value: Collection
    {
        NotEmptyRule<Value>(errorMessage: errorMessage).asAnyRule
    }
}
