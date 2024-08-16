//
//  ValidatorType.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public protocol ValidatorType {
    associatedtype Value
    associatedtype Rule: ValidationRule where Rule.Value == Value

    var rules: [Rule] { get }

    func validate(_ value: Value) throws
}

public extension ValidatorType {
    func validate(_ value: Value) throws {
        for rule in rules {
            try rule.validate(value)
        }
    }

    func validationResult(_ value: Value) -> Result<Void, Error> {
        do {
            try validate(value)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func validationErrorMessage(_ value: Value) -> String? {
        validationResult(value).error?.localizedDescription
    }
}
