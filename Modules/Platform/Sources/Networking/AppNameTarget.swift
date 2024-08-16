//
//  AppNameTarget.swift
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation
import Networking

private struct TargetTypeWrapper: TargetType {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let parameters: RequestParameters
    let headers: HTTPHeaders?

    init(target: TargetType) {
        self.baseURL = target.baseURL
        self.path = target.path
        self.method = target.method
        self.parameters = target.parameters
        self.headers = target.headers
    }
}

public protocol AppNameTarget: TargetType {
    var shouldAuthorize: Bool { get }
    var timeout: TimeInterval { get }
}

// swiftlint:disable force_unwrapping
public extension AppNameTarget {
    var baseURL: URL {
        switch Environment.scheme {
        case .dev:
            return URL(string: "#")!
        case .prod:
            return URL(string: "#")!
        }
    }

    var timeout: TimeInterval { 20 }

    func asURLRequest() throws -> URLRequest {
        let superTarget = TargetTypeWrapper(target: self)
        var request = try superTarget.asURLRequest()
        request.timeoutInterval = timeout
        return request
    }
}

// swiftlint:enable force_unwrapping

public struct AppNameTargetModel: AppNameTarget {
    public let path: String
    public let method: HTTPMethod
    public let parameters: RequestParameters
    public let headers: HTTPHeaders?
    public let shouldAuthorize: Bool
    public let timeout: TimeInterval

    public init(
        path: String,
        method: HTTPMethod = .get,
        parameters: RequestParameters = .requestPlain,
        headers: HTTPHeaders? = nil,
        shouldAuthorize: Bool = true,
        timeout: TimeInterval = 20
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.shouldAuthorize = shouldAuthorize
        self.timeout = timeout
    }
}
