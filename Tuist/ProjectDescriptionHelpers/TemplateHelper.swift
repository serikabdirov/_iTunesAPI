//
//  TemplateHelper.swift
//  ProjectDescriptionHelpers
//
//  Created by Zart Arn on 30.05.2024.
//

import Foundation

public struct TemplateHelper {
    
    public static var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: Date())
    }
}
