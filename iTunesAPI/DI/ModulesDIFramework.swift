//
//  ModulesDIFramework.swift
//
//  Created by Денис Кожухарь on 09.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import Start

class ModulesDIFramework: DIFramework {
    static func load(container: DIContainer) {
        container.append(part: StartDIPart.self)
    }
}
