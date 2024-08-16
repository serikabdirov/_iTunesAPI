import UIKit

public extension UIView {
    var isVisible: Bool {
        get { !isHidden }
        set { isHidden = !newValue }
    }

    /// Return 0 if safeAreaInsets.bottom > 0, or return offset if safeAreaInsets.bottom == 0
    func smartBottomOffset(_ offset: CGFloat) -> CGFloat {
        guard let window = UIWindow.keyWindow else {
            return offset
        }
        return (window.safeAreaInsets.bottom != 0) ? 0 : offset
    }
}
