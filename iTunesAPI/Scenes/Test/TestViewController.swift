//
//  TestViewController.swift
//
//  Created by Денис Кожухарь on 05.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import DITranquillity
import RouteComposer
import DesignSystem

final class TestViewControllerFactory: Factory {
    typealias ViewController = TestViewController

    typealias Context = Any?

    func build(with context: Any?) throws -> ViewController {
        TestViewController()
    }
}

class TestViewController: UIViewController {
    let scrollView = UIScrollView().then { i in
        i.alwaysBounceVertical = true
    }

    let contentStack = UIStackView().then { i in
        i.axis = .vertical
        i.spacing = 20
        i.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        i.isLayoutMarginsRelativeArrangement = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Test View Controller"
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentStack.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }

        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)

        contentStack.addArrangedSubview(button)
    }
}

extension TestViewController: NavigationBarAppearanceProvider, StatusBarAppearanceProvider {}
