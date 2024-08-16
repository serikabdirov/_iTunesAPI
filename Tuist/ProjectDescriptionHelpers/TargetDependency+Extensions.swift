import ProjectDescription

public extension TargetDependency {
    static func module(name: String) -> TargetDependency {
        .project(target: name, path: "//Modules/\(name)")
    }

    static func featureModule(name: String) -> TargetDependency {
        .project(target: name, path: "//Modules/FeatureModules/\(name)")
    }
}
