//
//  UIStoryboard+Extension.swift
//  BinaryNews
//
//  Created by Linh Nguyen on 8/31/20.
//  Copyright © 2020 BinaryFuel. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {
    enum Constants {
        static let loginViewController = "LoginViewController"
        static let registerViewController = "RegisterViewController"
        static let historyViewController = "HistoryViewController"
        static let paymentConfirmViewController = "PaymentConfirmViewController"
        static let profileViewController = "ProfileViewController"
        static let dashboardViewController = "DashboardViewController"
        static let updateProfileViewController = "UpdateProfileViewController"
        static let detailPaymentViewController = "DetailPaymentViewController"


    }
    static var main: UIStoryboard {
           return UIStoryboard(name: "Main", bundle: nil)
        
       }
    func instantiateLogin() -> LoginViewController? {
        return self.instantiateViewController(withIdentifier: Constants.loginViewController) as? LoginViewController

    }
    func instantiateRegisterViewController() -> RegisterViewController? {
           return self.instantiateViewController(withIdentifier: Constants.registerViewController) as? RegisterViewController

       }
    func instantiateHistoryViewController() -> HistoryViewController? {
        return self.instantiateViewController(withIdentifier: Constants.historyViewController) as? HistoryViewController

    }
    func instantiatePaymentConfirmViewController() -> PaymentConfirmViewController? {
        return self.instantiateViewController(withIdentifier: Constants.paymentConfirmViewController) as? PaymentConfirmViewController

    }
    func instantiateDashboardViewController() -> DashboardViewController? {
        return self.instantiateViewController(withIdentifier: Constants.dashboardViewController) as? DashboardViewController

    }
    func instantiateProfileViewController() -> ProfileViewController? {
        return self.instantiateViewController(withIdentifier: Constants.profileViewController) as? ProfileViewController

    }
    func instantiateUpdateProfileViewController() -> UpdateProfileViewController? {
        return self.instantiateViewController(withIdentifier: Constants.updateProfileViewController) as? UpdateProfileViewController

    }
    func instantiateDetailPaymentViewController() -> DetailPaymentViewController? {
        return self.instantiateViewController(withIdentifier: Constants.detailPaymentViewController) as? DetailPaymentViewController

    }
}

