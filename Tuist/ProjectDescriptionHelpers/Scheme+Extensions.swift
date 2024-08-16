import ProjectDescription

public extension Scheme {
    static func scheme(
        name: String,
        targetName: String
    ) -> Scheme {
        let debugConfigurationName = ConfigurationName.configuration("\(name)-Debug")
        let releaseConfigurationName = ConfigurationName.configuration("\(name)-Release")
        let targetReference: TargetReference = "\(targetName)"
        let scheme = Scheme(
            name: "\(targetName)-\(name)",
            buildAction: .buildAction(targets: [targetReference]),
            runAction: .runAction(
                configuration: debugConfigurationName,
                executable: targetReference
            ),
            archiveAction: .archiveAction(configuration: releaseConfigurationName),
            profileAction: .profileAction(configuration: debugConfigurationName),
            analyzeAction: .analyzeAction(configuration: debugConfigurationName)
        )
        return scheme
    }
}
