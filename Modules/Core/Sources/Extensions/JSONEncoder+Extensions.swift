//
//  JSONEncoder+Extensions.swift
//
//  Created by Денис Кожухарь on 31.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    static var convertingToSnakeCase: JSONEncoder {
        JSONEncoder().then { $0.keyEncodingStrategy = .convertToSnakeCase }
    }
}
