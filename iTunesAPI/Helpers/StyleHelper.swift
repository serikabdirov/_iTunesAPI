//
//  StyleHelper.swift
//
//  Created by Денис Кожухарь on 12.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DesignSystem
import SVProgressHUD

enum StyleHelper {
    static func setupStyles() {
        setupDefaultBackButton()
        setupSVProgressHUD()
        RFontFamily.registerAllCustomFonts()
    }

    private static func setupDefaultBackButton() {
        BackBarButtonItem.appearance().backImage = RAsset.Icons24.arrowBack.image
    }

    private static func setupSVProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundLayerColor(.white.withAlphaComponent(0.1))
        SVProgressHUD.setForegroundColor(.blue)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(0.15)
        SVProgressHUD.setRingThickness(4)
    }
}
