import ProjectDescription

public extension Project {
    /// Creates module Project with default settings
    static func module(
        name: String,
        packages: [Package] = [],
        targets: [Target],
        resourceSynthesizers: [ResourceSynthesizer] = [.assets(), .strings()]
    ) -> Project {
        Self.module(
            name: name,
            packages: packages,
            settings: .moduleWithCustomConfigurations(),
            targets: targets,
            resourceSynthesizers: resourceSynthesizers
        )
    }

    /// Creates module Project custom settings
    static func module(
        name: String,
        packages: [Package] = [],
        settings: Settings?,
        targets: [Target],
        resourceSynthesizers: [ResourceSynthesizer] = [.assets(), .strings()]
    ) -> Project {
        Project(
            name: name,
            options: .options(
                automaticSchemesOptions: .disabled,
                developmentRegion: Constants.developmentRegion,
                textSettings: .textSettings(usesTabs: false, indentWidth: 4, wrapsLines: true),
                xcodeProjectName: name
            ),
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [.glob(pattern: .relativeToManifest("Project.swift"))],
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
