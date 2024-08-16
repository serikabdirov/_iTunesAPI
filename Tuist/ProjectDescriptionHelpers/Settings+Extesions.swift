import ProjectDescription

public extension Settings {
    static func withCustomConfigurations(
        baseSetting: SettingsDictionary = [:],
        devDebugSettings: SettingsDictionary = [:],
        devReleaseSettings: SettingsDictionary = [:],
        prodDebugSettings: SettingsDictionary = [:],
        prodReleaseSettings: SettingsDictionary = [:]
    ) -> Settings {
        .settings(
            base: baseSetting,
            configurations: [
                Configuration.debug(
                    name: .configuration("Dev-Debug"),
                    settings: devDebugSettings,
                    xcconfig: "//Configurations/Dev-Debug.xcconfig"
                ),
                Configuration.release(
                    name: .configuration("Dev-Release"),
                    settings: devReleaseSettings,
                    xcconfig: "//Configurations/Dev-Release.xcconfig"
                ),
                Configuration.debug(
                    name: .configuration("Prod-Debug"),
                    settings: prodDebugSettings,
                    xcconfig: "//Configurations/Prod-Debug.xcconfig"
                ),
                Configuration.release(
                    name: .configuration("Prod-Release"),
                    settings: prodReleaseSettings,
                    xcconfig: "//Configurations/Prod-Release.xcconfig"
                )
            ],
            defaultSettings: .none
        )
    }

    static func moduleWithCustomConfigurations(
        baseSetting: SettingsDictionary = [:],
        devDebugSettings: SettingsDictionary = [:],
        devReleaseSettings: SettingsDictionary = [:],
        prodDebugSettings: SettingsDictionary = [:],
        prodReleaseSettings: SettingsDictionary = [:]
    ) -> Settings {
        .settings(
            base: baseSetting.merging([
                "ASSETCATALOG_COMPILER_APPICON_NAME": .string(""),
                "CODE_SIGN_STYLE": .string("AUTOMATIC"),
                "DEVELOPMENT_TEAM": .string(""),
                "CODE_SIGN_IDENTITY": .string(""),
                "PROVISIONING_PROFILE_SPECIFIER": .string(""),
                "DYLIB_INSTALL_NAME_BASE": .string("@rpath"),
                "SKIP_INSTALL": .string("YES")
            ]),
            configurations: [
                Configuration.debug(
                    name: .configuration("Dev-Debug"),
                    settings: devDebugSettings,
                    xcconfig: "//Configurations/Dev-Debug.xcconfig"
                ),
                Configuration.release(
                    name: .configuration("Dev-Release"),
                    settings: devReleaseSettings,
                    xcconfig: "//Configurations/Dev-Release.xcconfig"
                ),
                Configuration.debug(
                    name: .configuration("Prod-Debug"),
                    settings: prodDebugSettings,
                    xcconfig: "//Configurations/Prod-Debug.xcconfig"
                ),
                Configuration.release(
                    name: .configuration("Prod-Release"),
                    settings: prodReleaseSettings,
                    xcconfig: "//Configurations/Prod-Release.xcconfig"
                )
            ],
            defaultSettings: .none
        )
    }
}
