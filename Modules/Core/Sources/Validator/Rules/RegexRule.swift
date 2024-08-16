//
//  RegexRule.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public protocol RegexRule: ValidationRule where Value == String {
    var regex: String { get }
    var errorMessage: String { get }
}

extension RegexRule {
    var predicate: NSPredicate { NSPredicate(format: "SELF MATCHES %@", regex) }

    public func validate(_ value: Value) throws {
        if !predicate.evaluate(with: value) {
            throw ValidationError(message: errorMessage)
        }
    }
}
