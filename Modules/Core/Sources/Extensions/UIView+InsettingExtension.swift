import UIKit

public extension UIView {
    func insetting(
        with insets: UIEdgeInsets,
        horizontalAlignment: InsettingAlignment.Horizontal = .fill,
        verticalAlignment: InsettingAlignment.Vertical = .fill
    ) -> UIView {
        let wrapperView = UIView()
        wrapperView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        horizontalAlignment.align(view: self, into: wrapperView, insets: insets)
        verticalAlignment.align(view: self, into: wrapperView, insets: insets)
        return wrapperView
    }

    enum InsettingAlignment {
        public enum Horizontal {
            case left, right, center, fill
            func align(view: UIView, into wrapperView: UIView, insets: UIEdgeInsets) {
                switch self {
                case .left:
                    view.leftAnchor
                        .constraint(equalTo: wrapperView.leftAnchor, constant: insets.left)
                        .isActive = true
                    view.rightAnchor
                        .constraint(lessThanOrEqualTo: wrapperView.rightAnchor, constant: -insets.right)
                        .isActive = true
                case .right:
                    view.leftAnchor
                        .constraint(greaterThanOrEqualTo: wrapperView.leftAnchor, constant: insets.left)
                        .isActive = true
                    view.rightAnchor
                        .constraint(equalTo: wrapperView.rightAnchor, constant: -insets.right)
                        .isActive = true
                case .center:
                    view.leftAnchor
                        .constraint(greaterThanOrEqualTo: wrapperView.leftAnchor, constant: insets.left)
                        .isActive = true
                    view.rightAnchor
                        .constraint(lessThanOrEqualTo: wrapperView.rightAnchor, constant: -insets.right)
                        .isActive = true
                    view.centerXAnchor
                        .constraint(equalTo: wrapperView.centerXAnchor)
                        .with { $0.priority = UILayoutPriority(999) }
                        .isActive = true
                case .fill:
                    view.leftAnchor
                        .constraint(equalTo: wrapperView.leftAnchor, constant: insets.left)
                        .isActive = true
                    view.rightAnchor
                        .constraint(equalTo: wrapperView.rightAnchor, constant: -insets.right)
                        .isActive = true
                }
            }
        }

        public enum Vertical {
            case top, bottom, center, fill
            func align(view: UIView, into wrapperView: UIView, insets: UIEdgeInsets) {
                switch self {
                case .top:
                    view.topAnchor
                        .constraint(equalTo: wrapperView.topAnchor, constant: insets.top)
                        .isActive = true
                    view.bottomAnchor
                        .constraint(lessThanOrEqualTo: wrapperView.bottomAnchor, constant: -insets.bottom)
                        .isActive = true
                case .bottom:
                    view.topAnchor
                        .constraint(greaterThanOrEqualTo: wrapperView.topAnchor, constant: insets.top)
                        .isActive = true
                    view.bottomAnchor
                        .constraint(equalTo: wrapperView.bottomAnchor, constant: -insets.bottom)
                        .isActive = true
                case .center:
                    view.topAnchor
                        .constraint(greaterThanOrEqualTo: wrapperView.topAnchor, constant: insets.top)
                        .isActive = true
                    view.bottomAnchor
                        .constraint(lessThanOrEqualTo: wrapperView.bottomAnchor, constant: -insets.bottom)
                        .isActive = true
                    view.centerYAnchor
                        .constraint(equalTo: wrapperView.centerYAnchor)
                        .with { $0.priority = UILayoutPriority(999) }
                        .isActive = true
                case .fill:
                    view.topAnchor
                        .constraint(equalTo: wrapperView.topAnchor, constant: insets.top)
                        .isActive = true
                    view.bottomAnchor
                        .constraint(equalTo: wrapperView.bottomAnchor, constant: -insets.bottom)
                        .isActive = true
                }
            }
        }
    }
}
