import DITranquillity

extension DIContainer {
    static let shared: DIContainer = {
        let container = DIContainer()
        return container
    }()
}
