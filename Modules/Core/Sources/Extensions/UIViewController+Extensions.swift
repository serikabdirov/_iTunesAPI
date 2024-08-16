import UIKit

public extension UIViewController {
    func showAlert(
        title: String?,
        message: String?,
        animated: Bool = true,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction],
        tintColor: UIColor
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions {
            alertController.addAction(action)
        }

        let presentingVC = UIViewController.topMostController() ?? self
        alertController.view.tintColor = tintColor

        presentingVC.present(alertController, animated: animated) {
            alertController.view.tintColor = tintColor
        }
    }

    static func topMostController() -> UIViewController? {
        guard let window = UIWindow.keyWindow else { return nil }
        var topController = window.rootViewController
        while let vc = topController?.presentedViewController {
            topController = vc
        }
        return topController
    }
}
