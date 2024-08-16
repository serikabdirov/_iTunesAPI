import Foundation
import UIKit

public extension NSAttributedString {
    func mutable() -> NSMutableAttributedString {
        NSMutableAttributedString(attributedString: self)
    }

    func appended(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        let mutableString = mutable()
        mutableString.append(attrString)
        return mutableString
    }
}
