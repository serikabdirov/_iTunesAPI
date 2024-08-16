//
//  NukeHelper.swift
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Nuke

enum NukeHelper {
    static func setupDefaults() {
        var configuration = ImagePipeline.Configuration()
        configuration.isProgressiveDecodingEnabled = true
        configuration.isUsingPrepareForDisplay = true
        ImagePipeline.shared = ImagePipeline(configuration: configuration)
    }
}
