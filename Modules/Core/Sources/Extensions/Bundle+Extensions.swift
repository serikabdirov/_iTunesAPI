import Foundation

public extension Bundle {
    var displayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    var version: String? {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var build: String? {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
