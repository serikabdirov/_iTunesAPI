import UIKit

public extension UIColor {
    convenience init(hexValue: UInt64, alpha: CGFloat = 1.0) {
        self.init(
            displayP3Red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.replacingOccurrences(of: "#", with: "0x")
        var hexValue: UInt64 = 10_066_329
        Scanner(string: hexString).scanHexInt64(&hexValue)
        self.init(hexValue: hexValue, alpha: alpha)
    }

    static func random() -> UIColor {
        let hue = CGFloat(Int.random(in: 0 ... 256)) / 256.0
        let saturation = CGFloat(Int.random(in: 0 ... 128)) / 256.0 + 0.5
        let brightness = CGFloat(Int.random(in: 0 ... 128)) / 256.0 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    func lighter(by delta: CGFloat = 0.1) -> UIColor {
        adjust(by: delta)
    }

    func darker(by delta: CGFloat = 0.1) -> UIColor {
        adjust(by: -1 * delta)
    }

    func adjust(by delta: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(
            red: add(delta, toComponent: red),
            green: add(delta, toComponent: green),
            blue: add(delta, toComponent: blue),
            alpha: alpha
        )
    }
}

// MARK: - Luminance and Contrast extensions

public extension UIColor {
    /// Computes the relative luminance of the color.
    /// This assume that the color is using the sRGB color space.
    /// This is the relative brightness, normalized where 0 is black and 1 is white.
    var relativeLuminance: CGFloat {
        func toLinear(colorAttribute: CGFloat) -> CGFloat {
            if colorAttribute <= 0.03928 {
                return colorAttribute / 12.92
            } else {
                return pow((colorAttribute + 0.055) / 1.055, 2.4)
            }
        }

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let linearR = toLinear(colorAttribute: red)
        let linearG = toLinear(colorAttribute: green)
        let linearB = toLinear(colorAttribute: blue)

        let relativeLuminance = 0.2126 * linearR + 0.7152 * linearG + 0.0722 * linearB

        let precision: CGFloat = 1000
        return (relativeLuminance * CGFloat(precision)).rounded(.toNearestOrEven) / CGFloat(precision)
    }

    /// An enumeration which groups contrast ratios based on their readability.
    /// This follows the  Web Content Accessibility Guidelines (WCAG) 2.0.
    enum ContrastRatioResult {
        /// The contrast ratio between is enough for most people to distinguish the two colors.
        /// It can be used as text / background.
        case acceptable(CGFloat)

        /// The contrast ratio is not big enough for most people to distinguish the two colors.
        /// It should only be used for large text / background.
        case acceptableForLargeText(CGFloat)

        /// The contrast ratio between the two colors is low.
        /// It will be difficult for most to distinguish the two colors easily.
        /// Do not use these two colors as text / background.
        case low(CGFloat)

        init(value: CGFloat) {
            if value >= 4.5 {
                self = .acceptable(value)
            } else if value >= 3.0 {
                self = .acceptableForLargeText(value)
            } else {
                self = .low(value)
            }
        }

        var associatedValue: CGFloat {
            switch self {
            case let .acceptable(value),
                 let .acceptableForLargeText(value),
                 let .low(value):
                return value
            }
        }
    }

    /// Computes the contrast ratio between the current color instance, and the one passed in.
    /// Contrast ratios can range from 1 to 21 (commonly written 1:1 to 21:1).
    func contrastRatio(with color: UIColor) -> ContrastRatioResult {
        let luminance1 = max(color.relativeLuminance, relativeLuminance)
        let luminance2 = min(color.relativeLuminance, relativeLuminance)
        var contrastRatio = (luminance1 + 0.05) / (luminance2 + 0.05)
        let precision: CGFloat = 100
        contrastRatio = (contrastRatio * CGFloat(precision)).rounded(.toNearestOrEven) / CGFloat(precision)
        return ContrastRatioResult(value: contrastRatio)
    }
}

private extension UIColor {
    func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        max(0, min(1, toComponent + value))
    }
}
