//
//  Created by Denis Kozhukhar on 30.12.2022.
//

import UIKit

@resultBuilder
public enum UIViewHierarchyBuilder {
    public static func buildBlock(_ components: [UIView]...) -> [UIView] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ component: UIView) -> [UIView] {
        [component]
    }

    public static func buildExpression(_ component: UIView, subviews: () -> [UIView]) -> [UIView] {
        [component]
    }

    public static func buildExpression(_ component: UIView?) -> [UIView] {
        component.map { [$0] } ?? []
    }

    public static func buildExpression(_ components: [UIView]) -> [UIView] {
        components
    }

    public static func buildExpression(_ components: [UIView?]) -> [UIView] {
        components.compactMap { $0 }
    }

    public static func buildOptional(_ components: [UIView]?) -> [UIView] {
        components ?? []
    }

    public static func buildEither(first components: [UIView]) -> [UIView] {
        components
    }

    public static func buildEither(second components: [UIView]) -> [UIView] {
        components
    }

    public static func buildArray(_ components: [[UIView]]) -> [UIView] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ components: [UIView]) -> [UIView] {
        components
    }
}
