//
//  PlatformDIFramework.swift
//
//  Created by Денис Кожухарь on 10.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity

public class PlatformDIFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: NetworkingDIPart.self)
    }
}
