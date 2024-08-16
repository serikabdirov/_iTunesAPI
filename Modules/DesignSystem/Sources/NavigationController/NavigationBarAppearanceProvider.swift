import UIKit

public protocol NavigationBarAppearanceProvider {
    var navigationBarAppearance: NavigationBar.Appearance { get }

    func setNeedsUpdateNavigationControllerAppearance()
}

public extension NavigationBarAppearanceProvider {
    var navigationBarAppearance: NavigationBar.Appearance { .adaptiveBlurred }

    func setNeedsUpdateNavigationControllerAppearance() {
        if
            let viewController = self as? UIViewController,
            let navigationController = viewController.navigationController as? NavigationController
        {
            navigationController.setNeedsUpdateNavigationControllerAppearance(for: viewController)
        }
    }
}
