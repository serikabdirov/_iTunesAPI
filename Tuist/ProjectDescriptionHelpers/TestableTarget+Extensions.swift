import ProjectDescription

public extension TestableTarget {
    static func featureModule(name: String) -> TestableTarget {
        TestableTarget(target: TargetReference(
            projectPath: .relativeToRoot("Modules/FeatureModules/\(name)"),
            target: "\(name)Tests"
        ))
    }
}
