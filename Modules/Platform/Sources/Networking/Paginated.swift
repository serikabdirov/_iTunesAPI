//
//  Paginated.swift
//  Core
//
//  Created by Денис Кожухарь on 12.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import Foundation

public struct Paginated<Page, Result>: PaginatedModel {
    public let previous: Page?
    public let next: Page?
    public let results: [Result]

    public init(previous: Page?, next: Page?, results: [Result]) {
        self.previous = previous
        self.next = next
        self.results = results
    }

    public func nextPage() -> Page? {
        next
    }
}

public extension Paginated {
    static var empty: Self { .init(previous: nil, next: nil, results: []) }
}

public extension Paginated {
    func mapValues<T>(_ transform: (Result) -> T) -> Paginated<Page, T> {
        Paginated<Page, T>(previous: previous, next: next, results: results.map(transform))
    }
}

extension Paginated: Decodable where Page: Decodable, Result: Decodable {}

public typealias IntPaginated<Result> = Paginated<Int, Result>
public typealias StringPaginated<Result> = Paginated<String, Result>
