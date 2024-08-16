//
//  EqualLengthRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Accessibility
import Foundation

public struct EqualLengthRule<C: Collection>: ValidationRule {
    public let length: Int
    public let errorMessage: String

    public init(length: Int, errorMessage: String) {
        self.length = length
        self.errorMessage = errorMessage
    }

    public func validate(_ value: C) throws {
        if value.count == length {
            throw ValidationError(message: errorMessage)
        }
    }
}

public extension AnyValidationRule {
    static func equalLength(length: Int, errorMessage: String) -> Self
        where Self.Value: Collection
    {
        EqualLengthRule<Value>(length: length, errorMessage: errorMessage).asAnyRule
    }
}
