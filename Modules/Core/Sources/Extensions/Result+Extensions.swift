//
//  Result+Extensions.swift
//
//  Created by Денис Кожухарь on 16.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension Result {
    var value: Success? {
        if case let .success(value) = self {
            return value
        } else {
            return nil
        }
    }

    var error: Failure? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }
}
