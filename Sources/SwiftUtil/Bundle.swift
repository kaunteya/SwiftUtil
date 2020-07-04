import Foundation

public extension Bundle {
    var releaseVersion: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersion: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
