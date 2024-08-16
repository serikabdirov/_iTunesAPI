//
//  OptionalDateValue.swift
//  Platform
//
//  Created by Денис Кожухарь on 29.09.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

@_exported import BetterCodable
import Foundation

@propertyWrapper
public struct OptionalDateValue<Formatter: DateValueCodableStrategy> {
    private let value: Formatter.RawValue?
    public var wrappedValue: Date?

    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        self.value = wrappedValue.map(Formatter.encode)
    }
}

extension OptionalDateValue: Decodable where Formatter.RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        self.value = try Formatter.RawValue(from: decoder)
        if let value = value {
            self.wrappedValue = try Formatter.decode(value)
        } else {
            self.wrappedValue = nil
        }
    }
}

extension OptionalDateValue: Encodable where Formatter.RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension OptionalDateValue: Equatable, Hashable {
    public static func == (lhs: OptionalDateValue<Formatter>, rhs: OptionalDateValue<Formatter>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: OptionalDateValue<T>.Type,
        forKey key: Self.Key
    ) throws -> OptionalDateValue<T> where T.RawValue: Decodable {
        try decodeIfPresent(type, forKey: key) ?? OptionalDateValue<T>(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<T: DateValueCodableStrategy>(
        _ value: OptionalDateValue<T>,
        forKey key: KeyedEncodingContainer<K>.Key
    ) throws where T.RawValue: Encodable {
        if let wrappedValue = value.wrappedValue {
            try encode(T.encode(wrappedValue), forKey: key)
        }
    }
}
