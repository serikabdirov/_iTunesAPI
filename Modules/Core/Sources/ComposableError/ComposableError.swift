import Foundation

/// Main error type
/// Error that preserves underlying error
/// Allows you to determine the full error path
public protocol ComposableError: Swift.Error {
    /// Parent error
    var underlyingComposableError: ComposableError? { get }

    /// Unique error domain identifier
    var identifiableDomain: String { get }

    /// Unique error code
    var identifiableCode: String { get }
}

public extension ComposableError {
    /// Allows you to find a specific type of error among a connected list of `underlying` errors
    func traverseUnderlying<ErrorType: ComposableError>(
        searching type: ErrorType.Type
    ) -> ErrorType? {
        if let error = self as? ErrorType {
            return error
        } else {
            return underlyingComposableError?.traverseUnderlying(searching: type)
        }
    }

    var identifiableDomain: String {
        String(reflecting: type(of: self))
            .replacingOccurrences(of: "_.", with: "")
    }

    /// The full path of the error, taking into account the entire chain of `underlying` error
    var path: String {
        let path = identifiableDomain + " = " + identifiableCode
        if let underlyingError = underlyingComposableError {
            return path + " |-> " + underlyingError.path
        } else {
            return path
        }
    }
}
