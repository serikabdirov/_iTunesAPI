import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "Platform",
    dependencies: [
        .external(name: "BetterCodable"),
        .module(name: "Networking")
    ]
)
let project = Project.module(name: "Platform", targets: [target])
