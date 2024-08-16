//
//  DateValue+Extensions.swift
//  Platform
//
//  Created by Денис Кожухарь on 14.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import BetterCodable

extension DateValue: Equatable, Hashable {
    public static func == (lhs: DateValue<Formatter>, rhs: DateValue<Formatter>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
