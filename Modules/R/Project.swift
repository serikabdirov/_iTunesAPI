import ProjectDescription
import ProjectDescriptionHelpers

let target = Target(
    name: "R",
    platform: .iOS,
    product: .framework,
    bundleId: "\(Constants.bundleID)-R",
    deploymentTarget: Constants.deploymentTarget,
    sources: nil,
    resources: [.glob(pattern: .relativeToRoot("Modules/R/Resources/**"))]
)
let project = Project.module(
    name: "R",
    targets: [target],
    resourceSynthesizers: [.assets(), .strings(), .fonts()]
)
