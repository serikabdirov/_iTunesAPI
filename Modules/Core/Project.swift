import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "Core",
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa")
    ]
)
let project = Project.module(name: "Core", targets: [target])
