//
//  DecodingError+ComposableError.swift
//  Networking
//
//  Created by Денис Кожухарь on 16.02.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import Core
import Foundation

extension DecodingError: ComposableError {
    public var underlyingComposableError: ComposableError? {
        nil
    }

    public var identifiableCode: String {
        String(describing: self)
    }
}
