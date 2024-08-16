//
//  Environment.swift
//  Platform
//
//  Created by Денис Кожухарь on 13.03.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import Foundation

/// Namespace for Environment constants
public enum Environment {}

public extension Environment {
    enum Scheme {
        case dev, prod
    }

    static var scheme: Scheme {
        #if DEV
            return .dev
        #elseif PROD
            return .prod
        #else
            fatalError("There should be specific scheme")
        #endif
    }
}

public extension Environment {
    enum BuildType {
        case debug, release
    }

    static var buildType: BuildType {
        #if DEBUG
            return .debug
        #elseif RELEASE
            return .release
        #else
            fatalError("There should be specific scheme")
        #endif
    }
}
