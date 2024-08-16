import Foundation
import UIKit

public extension String {
    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }

    func height(
        withConstrainedWidth width: CGFloat,
        withConstrainedHeight height: CGFloat = .greatestFiniteMagnitude,
        font: UIFont,
        paragraphStyle: NSMutableParagraphStyle? = nil
    ) -> CGFloat {
        let constraintRect = CGSize(width: width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if let paragraph = paragraphStyle {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraph
        }
        let boundingBox = NSString(string: self)
            .boundingRect(with: constraintRect, options: options, attributes: attributes, context: nil)
        return ceil(boundingBox.height)
    }

    static var lorem: String {
        // swiftlint:disable:next line_length
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    static var loremIpsum: String {
        // swiftlint:disable:next line_length
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id fermentum sapien. Vivamus fringilla commodo magna sit amet luctus. Ut et eros justo. Vivamus sagittis sit amet odio ut viverra. Nullam neque purus, vulputate ut odio sed, mollis tempus purus. Vestibulum vestibulum, mi non malesuada pellentesque, odio mauris pellentesque nisi, ut lobortis odio libero sed diam. Integer venenatis lobortis augue quis sodales. Ut nec dui vitae dui imperdiet finibus id eu nibh. Phasellus et metus vel massa ornare vestibulum non vitae metus. Donec ac sapien laoreet, faucibus tortor id, interdum eros. Nulla metus risus, fermentum et ex vitae, ullamcorper blandit nulla. Praesent egestas arcu nisi, non mollis ex porta quis. Duis porta ac ligula venenatis fermentum. Aliquam tempus, justo a feugiat blandit, tortor mi porta urna, eget viverra nibh nibh sit amet dolor. Donec aliquam libero quis diam elementum, id sodales nisl maximus.\nNulla euismod leo purus, pellentesque luctus lectus aliquam vel. Nulla facilisi. Donec pharetra urna mattis vehicula sodales. Pellentesque commodo lacus nec pulvinar fermentum. Morbi tristique ex commodo enim tincidunt lacinia. Duis bibendum, sem sed molestie efficitur, dui ex blandit nisl, condimentum vulputate eros enim et enim. Ut semper urna vitae convallis euismod. Morbi ut eros porttitor, congue odio vitae, fermentum dolor."
    }

    func removing(prefix: String) -> String {
        if hasPrefix(prefix) {
            let start = index(startIndex, offsetBy: prefix.count)
            return String(self[start...])
        }
        return self
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}
