//
//  Date+Extensions.swift
//
//  Created by Денис Кожухарь on 30.09.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension TimeZone {
    // swiftlint:disable:next force_unwrapping
    static let utc = TimeZone(abbreviation: "UTC")!
}

public extension Calendar {
    static var utc: Calendar {
        Calendar.withTimeZone(.utc)
    }

    static func withTimeZone(_ timeZone: TimeZone) -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar
    }
}

public extension Date {
    func replaceTimeZone(_ timeZone: TimeZone, using calendar: Calendar = .current) -> Date? {
        var components = calendar.dateComponents(
            [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self
        )
        components.timeZone = timeZone
        return calendar.date(from: components)
    }
}
