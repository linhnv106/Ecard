//
//  AppConstants.swift
//  AmareLife
//
//  Created by Anton Poluboiarynov on 1/10/19.
//  Copyright © 2019 Amare Global. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol OpenLinkProviderProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: OpenLinkProviderProtocol { }

enum AppConstants {
    // Put all global constants here
    enum Links: String {
        case forgotPasswordProd = "https://www.amare.com/corporate/en-us/account/forgotpassword"
        case forgotPasswordDev = "https://replicatedsite-qa.azurewebsites.net/corporate/en-us/account/forgotpassword"
        case privacyPolicy = "https://www.amare.com/PrivacyPolicy.html"
        case termsAndConditions = "https://www.amare.com/TermsAndConditions.html"
    }
    
    // MARK: - Base URL
    static let devURL = URL(string: "http://ecard.darkvn.net/wp-json/jwt-auth/v1")!
    static let prodURL = URL(string: "http://ecard.darkvn.net/wp-json/jwt-auth/v1")!
    
    // MARK: - UI
    static let animationInterval: TimeInterval = 0.5
    static let activityIndicatorType: NVActivityIndicatorType = .ballSpinFadeLoader
    static let defaultCornerRadius: CGFloat = 8
    static let defaultAlertCornerRadius: CGFloat = 10
}

extension AppConstants.Links {
    func open(openLinkProvider provider: OpenLinkProviderProtocol = UIApplication.shared) {
        guard let url = URL(string: self.rawValue) else { return }
        provider.open(url, options: [:], completionHandler: nil)
    }
}
