//
//  DomainError.swift
//  Core
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Core
import Foundation

public struct DomainError<ErrorCode>: ComposableError {
    // MARK: - Public properties

    public var identifiableCode: String {
        String(describing: code)
    }

    public var underlyingComposableError: ComposableError?

    public let code: ErrorCode
    public let message: String

    // MARK: - Init

    public init(
        code: ErrorCode,
        message: String,
        underlyingComposableError: ComposableError?
    ) {
        self.code = code
        self.message = message
        self.underlyingComposableError = underlyingComposableError
    }
}

extension DomainError: LocalizedError {
    public var errorDescription: String? {
        message
    }
}

// MARK: - UnspecifiedDomainError

public enum UnspecifiedDomainErrorCode: String {
    case unknown
}

public typealias UnspecifiedDomainError = DomainError<UnspecifiedDomainErrorCode>
