import UIKit
import SafariServices
@_exported import UIKit
@_exported import Core
@_exported import R
@_exported import SnapKit

public enum DesignSystem {
    public enum Buttons {}
    public enum Views {}
    public enum ViewControllers {}
}

// MARK: - Buttons

public extension DesignSystem.Buttons {
    static func primaryButton(title: String) -> BaseButton {
        let button = BaseButton()

        button.text = title
        button.height = 56
        button.cornerRadius = 10
        button.backgroundColors[.normal] = .systemBlue
        button.backgroundColors[.highlighted] = .systemBlue.withAlphaComponent(0.75)
        button.backgroundColors[.disabled] = .systemBlue.withAlphaComponent(0.5)
        button.textColors[.normal] = .white
        button.textColors[.disabled] = .white
        button.font = .systemFont(ofSize: 16)
        button.contentInsets = UIEdgeInsets(top: 4, left: 32, bottom: 4, right: 32)

        return button
    }
}

// MARK: - Views & Rows

public extension DesignSystem.Views {
    /// Main UIRefreshControl
    static func refreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.layer.zPosition = -1
        refreshControl.tintColor = .blue
        return refreshControl
    }

    /// Main UIActivityIndicatorView
    static func activityIndicator(style: UIActivityIndicatorView.Style = .medium) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = .blue
        return activityIndicator
    }
}

// MARK: - ViewControllers

public extension DesignSystem.ViewControllers {
    /// Main system WebViewController
    static func webViewController(url: URL) -> UIViewController {
        let vc = SFSafariViewController(url: url)
        vc.dismissButtonStyle = .close
        vc.preferredControlTintColor = .blue
        return vc
    }
}
