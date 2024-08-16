import Alamofire
import Foundation

internal extension Mappings {
    /// Maps data received from the signal into a JSON object.
    /// - Returns: Result of mapping
    static func mapJSON(result: Result<Data, Swift.Error>) throws -> Any {
        let data = try result.get()
        return try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    }

    /// Maps data received from the signal into a Decodable object.
    ///
    /// - parameter atKeyPath: Optional key path at which to parse object.
    /// - parameter using: A `JSONDecoder` instance which is used to decode data to an object.

    /// Maps data received from the signal into a `Decodable` object
    /// - Parameters:
    ///   - type: Model type
    ///   - keyPath: Optional key path at which to parse object
    ///   - decoder: A `JSONDecoder` instance which is used to decode data to an object
    /// - Returns: `Decodable` object
    static func map<T: Decodable>(
        request: URLRequest?,
        response: HTTPURLResponse?,
        result: Result<Data, Swift.Error>,
        type: T.Type,
        atKeyPath keyPath: String? = nil,
        using decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let serializeToData: (Any) throws -> Data = { jsonObject in
            try JSONSerialization.data(withJSONObject: jsonObject, options: [.fragmentsAllowed])
        }
        let jsonData: Data
        if let keyPath = keyPath {
            guard let jsonDictionary = try mapJSON(result: result) as? NSDictionary,
                  let jsonObject = jsonDictionary.value(forKeyPath: keyPath)
            else {
                throw DecodableError.invalidKeyPath(request, response, result, keyPath)
            }
            do {
                jsonData = try serializeToData(jsonObject)
            } catch {
                let wrappedJsonObject = ["value": jsonObject]
                let wrappedJsonData: Data
                do {
                    wrappedJsonData = try serializeToData(wrappedJsonObject)
                } catch {
                    throw DecodableError.invalidJson(request, response, result, error)
                }
                do {
                    return try decoder.decode(DecodableWrapper<T>.self, from: wrappedJsonData).value
                } catch {
                    throw DecodableError.invalidJson(request, response, result, error)
                }
            }
        } else {
            jsonData = try result.get()
        }
        do {
            if jsonData.isEmpty {
                if let emptyJSONObjectData = "{}".data(using: .utf8),
                   let emptyDecodableValue = try? decoder.decode(T.self, from: emptyJSONObjectData)
                {
                    return emptyDecodableValue
                } else if let emptyJSONArrayData = "[{}]".data(using: .utf8),
                          let emptyDecodableValue = try? decoder.decode(T.self, from: emptyJSONArrayData)
                {
                    return emptyDecodableValue
                }
            }
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            throw DecodableError.invalidJson(request, response, result, error)
        }
    }
}

extension Mappings {
    enum DecodableError: Swift.Error {
        case invalidKeyPath(URLRequest?, HTTPURLResponse?, Result<Data, Swift.Error>, String)
        case invalidJson(URLRequest?, HTTPURLResponse?, Result<Data, Swift.Error>, Error)
    }
}

private struct DecodableWrapper<T: Decodable>: Decodable {
    let value: T
}
