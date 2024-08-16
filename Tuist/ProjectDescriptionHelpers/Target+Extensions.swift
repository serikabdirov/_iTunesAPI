import ProjectDescription

public extension Target {
    static func featureModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target(
            name: name,
            platform: .iOS,
            product: .framework,
            bundleId: "\(Constants.bundleID)-\(name)",
            deploymentTarget: Constants.deploymentTarget,
            sources: [
                .glob(.relativeToRoot("Modules/FeatureModules/\(name)/Sources/**/*.swift"))
            ],
            resources: [
                .glob(pattern: .relativeToRoot("Modules/FeatureModules/\(name)/**/Resources/**"))
            ],
            dependencies: dependencies + [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "DITranquillity"),
                .external(name: "RouteComposer"),
                .external(name: "SVProgressHUD"),
                .external(name: "Nuke"),
                .external(name: "NukeUI"),
                .external(name: "NukeExtensions"),
                .module(name: "DesignSystem"),
                .module(name: "Platform"),
            ]
        )
    }

    static func testsTarget(for mainTarget: Target) -> Target {
        Target(
            name: "\(mainTarget.name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(Constants.bundleID)-\(mainTarget.name)Tests",
            deploymentTarget: Constants.deploymentTarget,
            sources: [
                .glob(.relativeToRoot("Modules/FeatureModules/\(mainTarget.name)/Tests/**/*.swift"))
            ],
            resources: [
                .glob(pattern: .relativeToRoot("Modules/FeatureModules/\(mainTarget.name)/**/Resources/**"))
            ],
            dependencies: [.target(name: mainTarget.name)]
        )
    }

    static func module(name: String, dependencies: [TargetDependency] = []) -> Target {
        Target(
            name: name,
            platform: .iOS,
            product: .framework,
            bundleId: "\(Constants.bundleID)-\(name)",
            deploymentTarget: Constants.deploymentTarget,
            sources: [.glob(.relativeToRoot("Modules/\(name)/Sources/**/*.swift"))],
            dependencies: dependencies
        )
    }
}
