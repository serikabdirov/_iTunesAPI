import ProjectDescription

public enum Constants {}

public extension Constants {
    static let name = "iTunesAPI"
    static let bundleID = "com.smabdirov99.iTunesAPI"
    static let developmentRegion = "ru"
    static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)
}
