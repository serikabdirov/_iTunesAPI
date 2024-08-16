//
//  CustomRegexRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct CustomRegexRule: RegexRule {
    public let regex: String
    public let errorMessage: String

    public init(regex: String, errorMessage: String) {
        self.regex = regex
        self.errorMessage = errorMessage
    }
}

public extension AnyValidationRule where Value == CustomRegexRule.Value {
    static func customRegex(regex: String, errorMessage: String) -> Self {
        CustomRegexRule(regex: regex, errorMessage: errorMessage).asAnyRule
    }
}
