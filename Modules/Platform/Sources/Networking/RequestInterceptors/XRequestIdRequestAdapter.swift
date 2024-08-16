//
//  XRequestIdRequestAdapter.swift
//  Platform
//
//  Created by Денис Кожухарь on 14.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

final class XRequestIdRequestAdapter: RequestAdapter {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        urlRequest.setValue(UUID().uuidString.lowercased(), forHTTPHeaderField: "X-Request-ID")
        completion(.success(urlRequest))
    }
}
