import UIKit

public extension UIWindow {
    static var keyWindow: UIWindow? {
        UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }
    }

    static var topSafeArea: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.top ?? 0
    }

    static var bottomSafeArea: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.bottom ?? 0
    }
}
