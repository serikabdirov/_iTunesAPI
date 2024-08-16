import Core
import Foundation

extension Mappings.DecodableError: ComposableError {
    public var underlyingComposableError: ComposableError? {
        switch self {
        case .invalidKeyPath:
            return nil
        case let .invalidJson(_, _, _, error):
            return error as? ComposableError
        }
    }

    public var identifiableCode: String {
        String(describing: self)
    }
}
