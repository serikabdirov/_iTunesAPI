//
//  NumberFormatters.swift
//  Core
//
//  Created by Денис Кожухарь on 13.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public extension NumberFormatter {
    static var twoOptionalFractionsFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()

    static var oneOptionalFractionsFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()

    static var rubblesWithOptionalFractionsFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()
}
