import ProjectDescription
import ProjectDescriptionHelpers

let settings = Settings.withCustomConfigurations()
let schemes = [
    Scheme.scheme(name: "Dev", targetName: Constants.name),
    Scheme.scheme(name: "Prod", targetName: Constants.name)
]

let appTarget = Target(
    name: Constants.name,
    platform: .iOS,
    product: .app,
    productName: Constants.name,
    bundleId: Constants.bundleID,
    deploymentTarget: Constants.deploymentTarget,
    infoPlist: .file(path: "\(Constants.name)/App/Info.plist"),
    sources: ["\(Constants.name)/**/*.swift"],
    resources: ["\(Constants.name)/Resources/**"],
    copyFiles: nil,
    headers: nil,
    entitlements: nil,
    scripts: [],
    dependencies: [
        // External
        .external(name: "DITranquillity"),
        .external(name: "Alamofire"),
        .external(name: "SnapKit"),
        .external(name: "RouteComposer"),

        .module(name: "Platform"),
        .module(name: "DesignSystem"),

        .featureModule(name: "Start")
    ],
    settings: settings,
    coreDataModels: [],
    environment: [:],
    launchArguments: [],
    additionalFiles: []
)

let project = Project(
    name: Constants.name,
    options: .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: Constants.developmentRegion,
        textSettings: .textSettings(usesTabs: false, indentWidth: 4, wrapsLines: true),
        xcodeProjectName: Constants.name
    ),
    packages: [],
    settings: settings,
    targets: [appTarget],
    schemes: schemes,
    fileHeaderTemplate: nil,
    additionalFiles: [
        .glob(pattern: .relativeToRoot("Configurations/Config.xcconfig"))
    ],
    resourceSynthesizers: [.strings(), .assets()]
)
