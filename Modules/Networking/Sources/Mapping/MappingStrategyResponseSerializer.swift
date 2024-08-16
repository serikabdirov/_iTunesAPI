//
//  MappingStrategyResponseSerializer.swift
//  Networking
//
//  Created by Денис Кожухарь on 15.02.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

public struct MappingStrategyResponseSerializer<Value, Error: Swift.Error>: ResponseSerializer {
    // MARK: - Public properties

    public let dataPreprocessor: DataPreprocessor
    public let emptyResponseCodes: Set<Int>
    public let emptyRequestMethods: Set<HTTPMethod>

    // MARK: - Private properties

    private let valueMapping: Mapping<Value>
    private let errorMapping: Mapping<Error>
    private let mappingStrategy: MappingStrategy<Value, Error>

    /// Creates a `DataResponseSerializer` using the provided parameters.
    ///
    /// - Parameters:
    ///   - dataPreprocessor:    `DataPreprocessor` used to prepare the received `Data` for serialization.
    ///   - emptyResponseCodes:  The HTTP response codes for which empty responses are allowed. `[204, 205]` by default.
    ///   - emptyRequestMethods: The HTTP request methods for which empty responses are allowed. `[.head]` by default.
    public init(
        valueMapping: @escaping Mapping<Value>,
        errorMapping: @escaping Mapping<Error>,
        mappingStrategy: @escaping MappingStrategy<Value, Error>,
        dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods
    ) {
        self.valueMapping = valueMapping
        self.errorMapping = errorMapping
        self.mappingStrategy = mappingStrategy
        self.dataPreprocessor = dataPreprocessor
        self.emptyResponseCodes = emptyResponseCodes
        self.emptyRequestMethods = emptyRequestMethods
    }

    public func serialize(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Swift.Error?
    ) throws -> Value {
        if let error = error { throw error }

        guard var data = data, !data.isEmpty else {
            guard emptyResponseAllowed(forRequest: request, response: response) else {
                throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
            }

            let mappingInput = MappingInput<Data>(request: request, response: response, result: .success(Data()))
            return try mappingStrategy(mappingInput, valueMapping, errorMapping)
        }

        data = try dataPreprocessor.preprocess(data)

        let mappingInput = MappingInput<Data>(request: request, response: response, result: .success(data))
        return try mappingStrategy(mappingInput, valueMapping, errorMapping)
    }
}

public extension ResponseSerializer {
    static func strategySerializer<Value, Error: Swift.Error>(
        valueMapping: @escaping Mapping<Value>,
        errorMapping: @escaping Mapping<Error>,
        mappingStrategy: @escaping MappingStrategy<Value, Error>,
        dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods
    ) -> MappingStrategyResponseSerializer<Value, Error> where Self == MappingStrategyResponseSerializer<Value, Error> {
        MappingStrategyResponseSerializer<Value, Error>(
            valueMapping: valueMapping,
            errorMapping: errorMapping,
            mappingStrategy: mappingStrategy,
            dataPreprocessor: dataPreprocessor,
            emptyResponseCodes: emptyResponseCodes,
            emptyRequestMethods: emptyRequestMethods
        )
    }

    static func decodableStrategySerializer<Value: Decodable, Error: Decodable & Swift.Error>(
        valueType: Value.Type,
        errorType: Error.Type,
        valueMapping: @escaping Mapping<Value> = Mappings.decodable(Value.self),
        errorMapping: @escaping Mapping<Error> = Mappings.decodable(Error.self),
        mappingStrategy: @escaping MappingStrategy<Value, Error> = MappingStrategies.default(),
        dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
        emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
        emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods
    ) -> MappingStrategyResponseSerializer<Value, Error> where Self == MappingStrategyResponseSerializer<Value, Error> {
        MappingStrategyResponseSerializer<Value, Error>(
            valueMapping: valueMapping,
            errorMapping: errorMapping,
            mappingStrategy: mappingStrategy,
            dataPreprocessor: dataPreprocessor,
            emptyResponseCodes: emptyResponseCodes,
            emptyRequestMethods: emptyRequestMethods
        )
    }
}
