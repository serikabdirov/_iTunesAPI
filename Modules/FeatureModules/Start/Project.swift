import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.featureModule(name: "Start")
let project = Project.module(name: "Start", targets: [target])
