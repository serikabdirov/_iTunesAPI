import UIKit

public extension UINavigationController {
    /// Метод скрывает кнопку назад и отключает свайпы
    func hideBackButton() {
        topViewController?.navigationItem.hidesBackButton = true
        topViewController?.navigationItem.backBarButtonItem = nil
        topViewController?.navigationItem.leftBarButtonItem = nil
        interactivePopGestureRecognizer?.isEnabled = false
    }

    /// Метод добавляет стилизованную кнопку назад со стандартным поведением
    func addBackButton() {
        guard
            let navigation = self as? NavigationController,
            let topViewController = topViewController
        else {
            return
        }
        topViewController.navigationItem.hidesBackButton = true
        navigation.addBackButton(topViewController)
    }
}

open class NavigationController: UINavigationController, UIAdaptivePresentationControllerDelegate {
    // MARK: - Private Properties

    private var currentStatusBarStyle = UIStatusBarStyle.default
    private var currentStatusBarHidden = false
    private var currentStatusBarUpdateAnimation = UIStatusBarAnimation.fade

    // MARK: - Init

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
        updateNavigationBarNonAnimatableProperties(in: rootViewController)
        updateNavigationBarAppearanceAlongsidePushTransition(targetViewController: rootViewController, animated: false)
    }

    override public init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        setup()
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewControllers.first.map { viewController in
            updateNavigationBarNonAnimatableProperties(in: viewController)
            updateNavigationBarAppearanceAlongsidePushTransition(targetViewController: viewController, animated: false)
        }
    }

    // MARK: - StatusBar

    override open var childForStatusBarStyle: UIViewController? {
        nil
    }

    override open var childForStatusBarHidden: UIViewController? {
        nil
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        currentStatusBarStyle
    }

    override open var prefersStatusBarHidden: Bool {
        currentStatusBarHidden
    }

    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        currentStatusBarUpdateAnimation
    }

    // MARK: - Navigation

    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        for (index, item) in viewControllers.enumerated() {
            if
                index > 0,
                !item.navigationItem.hidesBackButton,
                item.navigationItem.leftBarButtonItem == nil,
                item is NavigationBarAppearanceProvider
            {
                addBackButton(item)
            }
            if let backItem = item.navigationItem
                .leftBarButtonItems?.compactMap({ $0 as? BackBarButtonItem }).first
            {
                addBackStackMenu(for: item, to: backItem)
            }
            updateNavigationBarNonAnimatableProperties(in: item)
        }
        guard let last = viewControllers.last else { return }
        updateNavigationBarAppearanceAlongsidePushTransition(targetViewController: last, animated: animated)
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController.navigationItem.hidesBackButton {
            interactivePopGestureRecognizer?.isEnabled = false
        } else if !viewControllers.isEmpty, viewController is NavigationBarAppearanceProvider {
            addBackButton(viewController)
        }
        super.pushViewController(viewController, animated: animated)
        updateNavigationBarNonAnimatableProperties(in: viewController)
        updateNavigationBarAppearanceAlongsidePushTransition(targetViewController: viewController, animated: animated)
    }

    @discardableResult
    override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let sourceViewController = viewControllers.last

        let popped = super.popToRootViewController(animated: animated)

        let destinationViewController = viewControllers.first

        guard
            let source = sourceViewController,
            let destination = destinationViewController
        else {
            return popped
        }

        adjustSwipeIfNeeded(destination, animated: animated)

        updateNavigationBarAppearanceAlongsidePopTransition(
            sourceViewController: source,
            destinationViewController: destination,
            animated: animated
        )

        return popped
    }

    @discardableResult
    override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let sourceViewController = viewControllers.last
        let popped = super.popToViewController(viewController, animated: animated)
        let destinationViewController = viewControllers.last

        guard
            let source = sourceViewController,
            let destination = destinationViewController
        else {
            return popped
        }

        adjustSwipeIfNeeded(destination, animated: animated)

        updateNavigationBarAppearanceAlongsidePopTransition(
            sourceViewController: source,
            destinationViewController: destination,
            animated: animated
        )

        return popped
    }

    @discardableResult
    override open func popViewController(animated: Bool = true) -> UIViewController? {
        let popped = super.popViewController(animated: animated)
        let destinationViewController = viewControllers.last

        guard
            let source = popped,
            let destination = destinationViewController
        else {
            return popped
        }

        adjustSwipeIfNeeded(destination, animated: animated)

        updateNavigationBarAppearanceAlongsidePopTransition(
            sourceViewController: source,
            destinationViewController: destination,
            animated: animated
        )

        return popped
    }

    override open func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        if viewControllerToPresent.presentationController?.delegate == nil {
            viewControllerToPresent.presentationController?.delegate = self
        }
    }

    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            self.setNeedsStatusBarAppearanceUpdate()
            completion?()
        }
    }

    open func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        setNeedsStatusBarAppearanceUpdate()
    }

    // MARK: - Public methods

    func setNeedsUpdateNavigationControllerAppearance(for viewController: UIViewController) {
        let updates = { [self, viewController] (isAnimated: Bool) in
            if let appearance = viewController.navBarAppearance {
                self.applyNavigationBarAppearance(
                    viewController: viewController,
                    appearance,
                    animated: isAnimated
                )
            }
            if let statusBarProvider = viewController as? StatusBarAppearanceProvider {
                self.setStatusBarStyle(provider: statusBarProvider)
            }
        }
        UIView.transition(with: navigationBar, duration: 0.25, options: [.transitionCrossDissolve]) {
            updates(true)
        }
    }

    func setNeedsUpdateStatusBarAppearance(for viewController: UIViewController) {
        if let statusBarProvider = viewController as? StatusBarAppearanceProvider {
            setStatusBarStyle(provider: statusBarProvider)
        }
    }
}

private extension NavigationController {
    @objc
    func backAction() {
        popViewController(animated: true)
    }

    func addBackButton(_ viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = nil
        let item = BackBarButtonItem(target: self, action: #selector(backAction))
        addBackStackMenu(for: viewController, to: item)
        viewController.navigationItem.leftBarButtonItem = item
        interactivePopGestureRecognizer?.isEnabled = true
    }

    func addBackStackMenu(for viewController: UIViewController, to item: BackBarButtonItem) {
        if #available(iOS 14.0, *) {
            let currentIndex = viewControllers.firstIndex(of: viewController) ?? viewControllers.endIndex
            let backStack = viewControllers[0 ..< currentIndex]
            let actions = backStack.compactMap { viewController -> UIAction? in
                guard let title = viewController.navigationItem.backButtonTitle ??
                    viewController.navigationItem.title ??
                    viewController.title
                else { return nil }
                return UIAction(title: title) { [weak self] _ in
                    self?.popToViewController(viewController, animated: true)
                }
            }
            if !actions.isEmpty {
                item.menu = UIMenu(children: actions.reversed())
            }
        }
    }

    func adjustSwipeIfNeeded(_ viewController: UIViewController, animated: Bool) {
        if
            viewController.navigationItem.leftBarButtonItem is BackBarButtonItem,
            interactivePopGestureRecognizer?.isEnabled == false
        {
            interactivePopGestureRecognizer?.isEnabled = true
        }

        // disable swipe on root view controller
        guard viewController == viewControllers.first else { return }
        let completion: (UIViewControllerTransitionCoordinatorContext?) -> Void = { [weak self] context in
            guard let self = self else { return }
            if !(context?.isCancelled ?? false), self.viewControllers.count == 1 {
                self.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        if animated, transitionCoordinator?.isAnimated == true {
            transitionCoordinator?.animate(alongsideTransition: nil, completion: completion)
        } else {
            completion(nil)
        }
    }

    func setup() {
        navigationBar.prefersLargeTitles = true
    }

    /// Устанавливает корректные значения свойств отображения, которые не связаны с анимацией
    /// - Свойства задаются единожды
    /// - Свойства могут быть переопределены в `viewController` в одном из методов его жизненного цикла,
    /// например,`viewDidLoad`
    func updateNavigationBarNonAnimatableProperties(in viewController: UIViewController) {
        interactivePopGestureRecognizer?.isEnabled = !viewController.navigationItem.hidesBackButton &&
            viewController != viewControllers.first
        interactivePopGestureRecognizer?.delegate = nil
        guard let appearance = viewController.navBarAppearance else { return }
        switch appearance {
        case .hidden,
             .standard:
            viewController.navigationItem.largeTitleDisplayMode = .never
        case .largeTitle:
            viewController.navigationItem.largeTitleDisplayMode = .always
        }
    }

    /// Анимирует `UINavigationBar` во время push-перехода
    func updateNavigationBarAppearanceAlongsidePushTransition(
        targetViewController: UIViewController,
        animated: Bool
    ) {
        let updates = { [self, targetViewController] (isAnimated: Bool) in
            if let appearance = targetViewController.navBarAppearance {
                self.applyNavigationBarAppearance(
                    viewController: targetViewController,
                    appearance,
                    animated: isAnimated
                )
            }
            if let statusBarProvider = targetViewController as? StatusBarAppearanceProvider {
                self.setStatusBarStyle(provider: statusBarProvider)
            }
        }

        if animated, transitionCoordinator?.isAnimated == true {
            transitionCoordinator?.animate(
                alongsideTransition: { _ in
                    updates(true)
                },
                completion: nil
            )
        } else {
            updates(false)
        }
    }

    /// Анимирует `UINavigationBar` во время pop-перехода.
    /// - Учитывает интерактивный `pop` по свайпу вправу.
    func updateNavigationBarAppearanceAlongsidePopTransition(
        sourceViewController: UIViewController,
        destinationViewController: UIViewController,
        animated: Bool
    ) {
        let updates = { [self, destinationViewController] (isAnimated: Bool) in
            if let appearance = destinationViewController.navBarAppearance {
                self.applyNavigationBarAppearance(
                    viewController: destinationViewController,
                    appearance,
                    animated: isAnimated
                )
            }
            if let statusBarProvider = destinationViewController as? StatusBarAppearanceProvider {
                self.setStatusBarStyle(provider: statusBarProvider)
            }
        }

        let completion: (UIViewControllerTransitionCoordinatorContext) -> Void = { context in
            if context.isCancelled {
                if let appearance = sourceViewController.navBarAppearance {
                    UIView.animate(withDuration: context.transitionDuration) {
                        self.applyNavigationBarAppearance(
                            viewController: sourceViewController,
                            appearance,
                            animated: context.isAnimated
                        )
                    }
                }
                if let statusBarProvider = sourceViewController as? StatusBarAppearanceProvider {
                    self.setStatusBarStyle(provider: statusBarProvider)
                }
            }
        }

        if animated, transitionCoordinator?.isAnimated == true {
            transitionCoordinator?.animate(
                alongsideTransition: { _ in
                    updates(true)
                },
                completion: completion
            )
        } else {
            updates(false)
        }
    }

    /// Применяет NavigationBarAppearance к `UINavigationBar`.
    /// Касается только экранов, реализующих протокол `NavigationBarAppearanceProvider`.
    func applyNavigationBarAppearance(
        viewController: UIViewController,
        _ navigationBarAppearance: NavigationBar.Appearance,
        animated: Bool
    ) {
        switch navigationBarAppearance {
        case .hidden:
            if !navigationBar.isHidden {
                setNavigationBarHidden(true, animated: animated)
            }
        case let .standard(
            standardAppearance,
            compactAppearance,
            scrollEdgeAppearance,
            compactScrollEdgeAppearance,
            barButtonsTintColor
        ),
        let .largeTitle(
            standardAppearance,
            compactAppearance,
            scrollEdgeAppearance,
            compactScrollEdgeAppearance,
            barButtonsTintColor
        ):
            if navigationBar.isHidden {
                setNavigationBarHidden(false, animated: animated)
            }
            navigationBar.tintColor = barButtonsTintColor
            viewController.navigationItem.standardAppearance = standardAppearance
            viewController.navigationItem.compactAppearance = compactAppearance
            viewController.navigationItem.scrollEdgeAppearance = scrollEdgeAppearance
            if #available(iOS 15.0, *) {
                viewController.navigationItem.compactScrollEdgeAppearance = compactScrollEdgeAppearance
            }
            navigationBar.backIndicatorImage = UIImage()
            navigationBar.backIndicatorTransitionMaskImage = UIImage()
        }
    }

    func setStatusBarStyle(provider: StatusBarAppearanceProvider) {
        currentStatusBarStyle = provider.statusBarAppearance.statusBarStyle.preferred
        currentStatusBarHidden = provider.statusBarAppearance.isStatusBarHidden
        currentStatusBarUpdateAnimation = provider.statusBarAppearance.statusBarUpdateAnimation
        setNeedsStatusBarAppearanceUpdate()
    }
}

private extension UIViewController {
    var navBarAppearance: NavigationBar.Appearance? {
        (self as? NavigationBarAppearanceProvider)?.navigationBarAppearance
    }
}
