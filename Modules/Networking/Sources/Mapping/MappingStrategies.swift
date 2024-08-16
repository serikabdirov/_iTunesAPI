import Alamofire
import Foundation

/// Algorithm for data mapping
/// Defines concrete `Mapping`'s call order
public typealias MappingStrategy<Value, Error: Swift.Error> = (
    MappingInput<Data>,
    Mapping<Value>,
    Mapping<Error>
) throws -> Value

/// Namespace for `MappingStrategy`'s factories
public enum MappingStrategies {}

public extension MappingStrategies {
    /// Default `MappingStrategy`
    static func `default`<Value, Error: Swift.Error>() -> MappingStrategy<Value, Error> {
        { input, valueMapping, errorMapping in
            var isSuccessfulCode = false
            if (200 ..< 300).contains(input.response?.statusCode ?? 0) {
                isSuccessfulCode = true
            }
            do {
                let value = try valueMapping(input)
                return value
            } catch {
                if isSuccessfulCode {
                    throw error
                }
                let error = try errorMapping(input)
                throw error
            }
        }
    }
}
