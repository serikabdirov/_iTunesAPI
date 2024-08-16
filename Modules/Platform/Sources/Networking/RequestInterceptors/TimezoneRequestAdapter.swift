//
//  TimezoneRequestAdapter.swift
//  Platform
//
//  Created by Денис Кожухарь on 06.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

final class TimezoneRequestAdapter: RequestAdapter {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        let timezone = Calendar.current.timeZone.identifier
        urlRequest.setValue(timezone, forHTTPHeaderField: "User-Timezone")
        completion(.success(urlRequest))
    }
}
