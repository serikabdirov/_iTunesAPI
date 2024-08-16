import UIKit

public final class BackBarButtonItem: UIBarButtonItem {
    /// Иконка кнопки назад, устанавливается через appearance
    ///  Пример:
    /// BackBarButtonItem.appearance().backImage = Image.back
    public dynamic var backImage: UIImage? {
        get { image }
        set { image = newValue }
    }

    /// Инициализатор стилизованной кнопки назад
    ///
    /// - Parameters:
    ///   - target: таргет
    ///   - action: действие
    public convenience init(target: Any?, action: Selector?) {
        let image = Self.appearance().backImage ?? UIImage(systemName: "chevron.backward")
        self.init(image: image, style: .plain, target: target, action: action)
    }
}
