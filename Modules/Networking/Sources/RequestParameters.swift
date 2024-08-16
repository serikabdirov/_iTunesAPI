import Alamofire
import Core
import Foundation

public enum RequestParameters {
    /// A request with no additional data
    case requestPlain

    /// A requests body set with data
    case requestData(Data)

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable, encoder: JSONEncoder = JSONEncoder.convertingToSnakeCase)

    /// A requests body set with encoded parameters
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)

    /// A requests body set with data, combined with url parameters
    case requestCompositeData(bodyData: Data, urlParameters: Parameters, encoding: ParameterEncoding)

    /// A requests body set with  `Encodable` type, combined with url parameters
    case requestCompositeEncodable(
        Encodable,
        encoder: JSONEncoder = JSONEncoder.convertingToSnakeCase,
        urlParameters: Parameters,
        encoding: ParameterEncoding
    )

    /// A requests body set with encoded parameters, combined with url parameters
    case requestCompositeParameters(
        bodyParameters: Parameters,
        bodyEncoding: ParameterEncoding = JSONEncoding.default,
        urlParameters: Parameters,
        urlEncoding: ParameterEncoding
    )
}

extension RequestParameters {
    func fill(request: URLRequest) throws -> URLRequest {
        var request = request
        switch self {
        case .requestPlain:
            break
        case let .requestData(data):
            request.httpBody = data
        case let .requestJSONEncodable(encodable, encoder):
            request.httpBody = try encoder.encode(encodable.anyEncodable)
            if request.headers["Content-Type"] == nil {
                request.headers.update(.contentType("application/json"))
            }
        case let .requestParameters(parameters, encoding):
            request = try encoding.encode(request, with: parameters)
        case let .requestCompositeData(bodyData, urlParameters, encoding):
            request = try encoding.encode(request, with: urlParameters)
            request.httpBody = bodyData
        case let .requestCompositeEncodable(encodable, encoder, urlParameters, encoding):
            request = try encoding.encode(request, with: urlParameters)
            request.httpBody = try encoder.encode(encodable.anyEncodable)
            if request.headers["Content-Type"] == nil {
                request.headers.update(.contentType("application/json"))
            }
        case let .requestCompositeParameters(bodyParameters, bodyEncoding, urlParameters, urlEncoding):
            request = try urlEncoding.encode(request, with: urlParameters)
            request = try bodyEncoding.encode(request, with: bodyParameters)
        }
        return request
    }
}
