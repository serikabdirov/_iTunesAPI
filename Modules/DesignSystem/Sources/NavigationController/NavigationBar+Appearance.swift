import UIKit

public enum NavigationBar {
    public enum Appearance {
        case hidden

        case standard(
            standardAppearance: UINavigationBarAppearance,
            compactAppearance: UINavigationBarAppearance,
            scrollEdgeAppearance: UINavigationBarAppearance,
            compactScrollEdgeAppearance: UINavigationBarAppearance,
            barButtonsTintColor: UIColor
        )

        case largeTitle(
            standardAppearance: UINavigationBarAppearance,
            compactAppearance: UINavigationBarAppearance,
            scrollEdgeAppearance: UINavigationBarAppearance,
            compactScrollEdgeAppearance: UINavigationBarAppearance,
            barButtonsTintColor: UIColor
        )
    }
}

public extension NavigationBar.Appearance {
    static var adaptiveBlurred: NavigationBar.Appearance {
        let standardAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithDefaultBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black]
        }
        let scrollEdgeAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black]
        }
        return .standard(
            standardAppearance: standardAppearance,
            compactAppearance: standardAppearance,
            scrollEdgeAppearance: scrollEdgeAppearance,
            compactScrollEdgeAppearance: scrollEdgeAppearance,
            barButtonsTintColor: .black
        )
    }
}
