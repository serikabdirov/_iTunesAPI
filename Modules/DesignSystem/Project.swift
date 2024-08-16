import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "DesignSystem",
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "SVProgressHUD"),
        .external(name: "Nuke"),
        .external(name: "NukeUI"),
        .external(name: "NukeExtensions"),
        .module(name: "R"),
        .module(name: "Core"),
    ]
)
let project = Project.module(name: "DesignSystem", targets: [target])
