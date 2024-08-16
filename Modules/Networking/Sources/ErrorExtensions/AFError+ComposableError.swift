import Alamofire
import Core

extension AFError: ComposableError {
    public var identifiableCode: String {
        String(describing: self)
    }

    public var underlyingComposableError: ComposableError? {
        underlyingError as? ComposableError
    }
}
