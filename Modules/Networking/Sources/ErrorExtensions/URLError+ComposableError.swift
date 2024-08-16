import Core
import Foundation

extension URLError: ComposableError {
    public var underlyingComposableError: ComposableError? { nil }

    public var identifiableCode: String {
        "\(code.rawValue) (\(localizedDescription))"
    }
}
