//
//  RoutersDIFramework.swift
//
//  Created by Денис Кожухарь on 09.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity

class RoutersDIFramework: DIFramework {
    static func load(container: DIContainer) {
        StartRouterImpl.register(in: container)
    }
}
