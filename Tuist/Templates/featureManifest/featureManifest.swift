import ProjectDescription
import ProjectDescriptionHelpers

private let moduleAttribute: Template.Attribute = .required("module")
private let yearAttr: Template.Attribute = .optional("year", default: .init(stringLiteral: TemplateHelper.year))

let featureManifestTemplate = Template(
    description: "Template for generate feature module manifests",
    attributes: [
        moduleAttribute,
    ],
    items: [
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Business/\(moduleAttribute)Service.swift",
            templatePath: "../feature/business/Service.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Business/\(moduleAttribute)ServiceImpl.swift",
            templatePath: "../feature/business/ServiceImpl.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Business/\(moduleAttribute)Target.swift",
            templatePath: "../feature/business/Target.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Business/\(moduleAttribute)BusinessDIPart.swift",
            templatePath: "../feature/business/BusinessDIPart.stencil"
        ),
        .string(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Business/Models/.gitkeep",
            contents: ""
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/\(moduleAttribute)DIFramework.swift",
            templatePath: "DIFramework.stencil"
        ),
    ]
)
