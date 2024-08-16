import UIKit

public protocol StatusBarAppearanceProvider {
    var statusBarAppearance: StatusBar.Appearance { get }

    func setNeedsUpdateStatusBarAppearance()
}

public extension StatusBarAppearanceProvider {
    var statusBarAppearance: StatusBar.Appearance { .dark }

    func setNeedsUpdateStatusBarAppearance() {
        if
            let viewController = self as? UIViewController,
            let navigationController = viewController.navigationController as? NavigationController
        {
            navigationController.setNeedsUpdateStatusBarAppearance(for: viewController)
        }
    }
}
