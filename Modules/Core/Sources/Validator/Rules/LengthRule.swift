//
//  LengthRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Accessibility
import Foundation

public struct LengthRule<R: RangeExpression, C: Collection>: ValidationRule where R.Bound == Int {
    public let range: R
    public let errorMessage: String

    public init(range: R, errorMessage: String) {
        self.range = range
        self.errorMessage = errorMessage
    }

    public func validate(_ value: C) throws {
        if !range.contains(value.count) {
            throw ValidationError(message: errorMessage)
        }
    }
}

public extension AnyValidationRule {
    static func length<R: RangeExpression>(
        range: R,
        errorMessage: String
    ) -> Self
        where Self.Value: Collection, R.Bound == Int
    {
        LengthRule<R, Value>(range: range, errorMessage: errorMessage).asAnyRule
    }
}
