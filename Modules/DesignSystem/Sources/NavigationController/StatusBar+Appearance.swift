import UIKit

public enum StatusBar {
    public enum Style {
        /// Стандартный стиль, который красит текст статусбара в тёмный в светлой теме, и в светлый в тёмной теме.
        case `default`
        /// Инвертированный стиль, который красит текст статусбара в светлый в светлой теме, и в тёмный в тёмной теме.
        case inverted
        /// Тёмный стиль текста для статусбара (в любой теме).
        case dark
        /// Светлый стиль текста для статусбара (в любой теме).
        case light
    }

    public struct Appearance {
        let statusBarStyle: Style
        let isStatusBarHidden: Bool
        let statusBarUpdateAnimation: UIStatusBarAnimation
    }
}

public extension StatusBar.Appearance {
    static let light = StatusBar.Appearance(
        statusBarStyle: .light,
        isStatusBarHidden: false,
        statusBarUpdateAnimation: .fade
    )

    static let dark = StatusBar.Appearance(
        statusBarStyle: .dark,
        isStatusBarHidden: false,
        statusBarUpdateAnimation: .fade
    )

    static let hidden = StatusBar.Appearance(
        statusBarStyle: .dark,
        isStatusBarHidden: true,
        statusBarUpdateAnimation: .fade
    )
}

extension StatusBar.Style {
    var preferred: UIStatusBarStyle {
        switch self {
        case .default:
            var style: UIStatusBarStyle = .default
            if #available(iOS 13.0, *) {
                style = UITraitCollection.current.userInterfaceStyle == .dark ? .lightContent : .darkContent
            }
            return style
        case .inverted:
            var style: UIStatusBarStyle = .default
            if #available(iOS 13.0, *) {
                style = UITraitCollection.current.userInterfaceStyle == .dark ? .darkContent : .lightContent
            }
            return style
        case .light:
            return .lightContent
        case .dark:
            if #available(iOS 13.0, *) {
                return .darkContent
            }
            return .default
        }
    }
}
