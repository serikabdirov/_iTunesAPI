//
//  EmailRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public struct EmailRule: RegexRule {
    public var regex: String { "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" }
    public let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

public extension AnyValidationRule where Value == EmailRule.Value {
    static func email(errorMessage: String) -> Self { EmailRule(errorMessage: errorMessage).asAnyRule }
}
