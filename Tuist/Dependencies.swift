import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(
                url: "https://github.com/Alamofire/Alamofire",
                requirement: .upToNextMajor(from: "5.9.0")
            ),
            .remote(
                url: "https://github.com/ReactiveX/RxSwift.git",
                requirement: .upToNextMajor(from: "6.7.0")
            ),
            .remote(
                url: "https://github.com/SnapKit/SnapKit",
                requirement: .upToNextMajor(from: "5.7.0")
            ),
            .remote(
                url: "https://github.com/ivlevAstef/DITranquillity",
                requirement: .upToNextMajor(from: "4.6.0")
            ),
            .remote(
                url: "https://github.com/ekazaev/route-composer",
                requirement: .upToNextMajor(from: "2.10.2")
            ),
            .remote(
                url: "https://gitlab.spider.ru/forks/SVProgressHUD.git",
                requirement: .upToNextMajor(from: "2.2.0")
            ),
            .remote(
                url: "https://github.com/kean/Nuke",
                requirement: .upToNextMajor(from: "12.8.0")
            ),
            .remote(
                url: "https://github.com/marksands/BetterCodable",
                requirement: .upToNextMajor(from: "0.4.0")
            )
        ],
        productTypes: [
            "Alamofire": .framework,
            "RxSwift": .framework,
            "SnapKit": .framework,
            "DITranquillity": .framework,
            "RouteComposer": .framework,
            "SVProgressHUD": .framework,
            "Nuke": .framework,
            "NukeUI": .framework,
            "NukeExtensions": .framework,
            "BetterCodable": .framework
        ],
        baseSettings: .settings(configurations: [
            .debug(name: "Dev-Debug"),
            .debug(name: "Prod-Debug"),
            .release(name: "Dev-Release"),
            .release(name: "Prod-Release")
        ])
    ),
    platforms: [.iOS]
)
