//
//  Dependencies.swift
//
//  Created by Денис Кожухарь on 09.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import Foundation
import Platform
import Start
import UIKit

enum DependencyRegistrar {
    static func register(container: DIContainer) {
        container.append(framework: RoutersDIFramework.self)
        container.append(framework: ModulesDIFramework.self)
        container.append(framework: PlatformDIFramework.self)

        #if DEBUG
            // Make log level to info or verbose to see details in case of validation error
            DISetting.Log.level = .error
            DISetting.Log.tab = "-DI-"
            if !container.makeGraph().checkIsValid(checkGraphCycles: true) {
                fatalError("Invalid DI graph, check logs")
            }
        #else
            DISetting.Log.level = .error
        #endif
    }
}
