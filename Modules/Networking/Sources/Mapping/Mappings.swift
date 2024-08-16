import Alamofire
import Foundation

public struct MappingInput<Value> {
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    public let result: Result<Value, Swift.Error>
}

/// Perform mapping of `MappingInput` to model `T`
public typealias Mapping<T> = (MappingInput<Data>) throws -> T

/// Namespace for `Mapping`'s factories
public enum Mappings {}

public extension Mappings {
    /// Creates `Mapping` for `Decodable` models
    /// - Parameters:
    ///   - type: Model type
    ///   - keyPath: Path for model mapping inside JSON-hierarchy
    ///   - decoder: `JSONDecoder` used to perform decoding
    /// - Returns: Decodable `Mapping`
    static func decodable<Value: Decodable>(
        _ type: Value.Type,
        atKeyPath keyPath: String? = nil,
        using decoder: JSONDecoder = JSONDecoder()
    ) -> Mapping<Value> {
        { input in
            try Mappings.map(
                request: input.request,
                response: input.response,
                result: input.result,
                type: type,
                atKeyPath: keyPath,
                using: decoder
            )
        }
    }
}
