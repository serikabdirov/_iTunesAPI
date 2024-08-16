import ProjectDescription
import ProjectDescriptionHelpers

private let moduleAttribute: Template.Attribute = .required("module")
private let nameAttribute: Template.Attribute = .required("name")
private let yearAttr: Template.Attribute = .optional("year", default: .init(stringLiteral: TemplateHelper.year))

let featureTemplate = Template(
    description: "Template for generate feature modules",
    attributes: [
        moduleAttribute,
        nameAttribute,
        .optional("author", default: "")
    ],
    items: [
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)DIPart.swift",
            templatePath: "DIPart.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)Factory.swift",
            templatePath: "Factory.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)Router.swift",
            templatePath: "Router.stencil"
        ),
        .file(
            path: "\(Constants.name)/Routers/\(moduleAttribute)/\(nameAttribute)RouterImpl.swift",
            templatePath: "RouterImpl.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)View.swift",
            templatePath: "View.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)ViewController.swift",
            templatePath: "ViewController.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)ViewModel.swift",
            templatePath: "ViewModel.stencil"
        ),
        .string(
            path: "Modules/FeatureModules/\(moduleAttribute)/Resources/\(nameAttribute).strings",
            contents: #""test" = "test";"#
        )
    ]
)
