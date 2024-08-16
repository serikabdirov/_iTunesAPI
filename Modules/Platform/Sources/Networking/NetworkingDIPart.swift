//
//  NetworkingDIPart.swift
//
//  Created by Денис Кожухарь on 30.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import Networking

class NetworkingDIPart: DIPart {
    static func load(container: DIContainer) {
        // Event monitors
        #if DEBUG
            container.register { NetworkActivityLogger(level: .debug) }
                .lifetime(.perRun(.weak))
        #endif

        // Adapters
        container.register(TimezoneRequestAdapter.init)
        container.register(XRequestIdRequestAdapter.init)

        container.register { (container: DIContainer) in
            ApiClient(
                interceptor: Interceptor(
                    adapters: [
                        container.resolve() as TimezoneRequestAdapter,
                        container.resolve() as XRequestIdRequestAdapter
                    ] as [RequestAdapter]
                ),
                eventMonitors: ([
                    container.resolve() as NetworkActivityLogger?,
                ] as [EventMonitor?]).compactMap { $0 }
            )
        }
        .default()
    }
}
