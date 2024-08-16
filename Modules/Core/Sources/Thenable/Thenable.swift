import CoreGraphics
import Foundation

public protocol Thenable {}

public extension Thenable where Self: Any {
    /// Позволяет изменять свойства структуры в замыкании, сразу после ее инициализации
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Позволяет выполнить над объектом ряд операций, описанных в замыкании
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

public extension Thenable where Self: AnyObject {
    /// Позволяет изменять свойства объекта сразу после инициализации
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .center
    ///       $0.textColor = UIColor.black
    ///       $0.text = "Hello, World!"
    ///     }
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Thenable {}
extension JSONDecoder: Thenable {}
extension JSONEncoder: Thenable {}

extension CGPoint: Thenable {}
extension CGRect: Thenable {}
extension CGSize: Thenable {}
extension CGVector: Thenable {}
extension Array: Thenable {}
extension Dictionary: Thenable {}
extension Set: Thenable {}

#if os(iOS)
    import UIKit.UIGeometry
    extension UIEdgeInsets: Thenable {}
    extension UIOffset: Thenable {}
    extension UIRectEdge: Thenable {}
#endif
