//
//  PaginatedModel.swift
//  Core
//
//  Created by Денис Кожухарь on 12.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation

public protocol PaginatedModel {
    associatedtype Page
    func nextPage() -> Page?
}
