import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "Networking",
    dependencies: [
        .external(name: "Alamofire"),
        .module(name: "Core")
    ]
)
let project = Project.module(name: "Networking", targets: [target])
