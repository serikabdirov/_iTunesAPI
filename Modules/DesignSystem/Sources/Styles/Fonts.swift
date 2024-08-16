import R
import UIKit

public extension UIFont {
    static func montserratBold(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.bold.font(size: size)
    }

    static func montserratSemiBold(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.semiBold.font(size: size)
    }

    static func montserratMedium(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.medium.font(size: size)
    }

    static func montserratRegular(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.regular.font(size: size)
    }

    // MARK: - Title

    /// Montserrat-Bold 24
    static let h1Bold = montserratBold(size: 24)
    /// Montserrat-SemiBold 24
    static let h1SemiBold = montserratSemiBold(size: 24)
    /// Montserrat-Medium 24
    static let h1Medium = montserratMedium(size: 24)

    // MARK: - Text

    /// Montserrat-Medium 16
    static let body1Medium = montserratMedium(size: 16)
    /// Montserrat-SemiBold 16
    static let body1Semibold = montserratSemiBold(size: 16)
}
