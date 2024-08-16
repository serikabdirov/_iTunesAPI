//
//  RouterType.swift
//
//  Created by Денис Кожухарь on 17.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation
import UIKit

protocol RouterType: AnyObject {
    func openURLString(_ urlString: String)
    func openURL(_ url: URL)
    func openURL(_ url: URL, completion: ((Bool) -> Void)?)
    func share(activityItems: [Any])
    func goToSettings()
}

extension RouterType {
    func openURLString(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        openURL(url)
    }

    func openURL(_ url: URL) {
        openURL(url, completion: nil)
    }

    func openURL(_ url: URL, completion: ((Bool) -> Void)?) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: completion)
        }
    }

    func share(activityItems: [Any]) {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        UIViewController.topMostController()?.present(vc, animated: true)
    }

    func goToSettings() {
        openURLString(UIApplication.openSettingsURLString)
    }
}
