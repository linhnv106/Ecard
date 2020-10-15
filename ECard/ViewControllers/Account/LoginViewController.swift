//
//  LoginViewController.swift
//  ECard
//
//  Created by LinhNguyen on 9/4/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import Moya
import SCLAlertView
class LoginViewController: UIViewController {
    @IBOutlet var userNameLB: UITextField!

    @IBOutlet var pwdLB: UITextField!

    @IBOutlet var loginBtn: UIButton!

    @IBOutlet var registerLB: UILabel!

    @IBAction func didTapLoginButton(_ sender: Any) {
        login()
        
    }
    var loginManager = DataManager<Credentials, LoginResponse>()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTegister))
        registerLB.isUserInteractionEnabled = true
        registerLB.addGestureRecognizer(tap)
        title = "LOGIN"
    }
    @objc func didTapTegister(sender: UITapGestureRecognizer) {
        print("tap working")
        if let vc = UIStoryboard.main.instantiateRegisterViewController() {
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    // MARK: Login
      func login() {
          guard let email = userNameLB.text else { return }
          guard let password = pwdLB.text else { return }
          let credentials = Credentials(email: email, password: password)

        showIndicator()
          loginManager.load(target: credentials, completion: completeLogin)
      }

      func completeLogin(with result: Result<LoginResponse, MoyaError>) {
          switch result {
          case .success(let loginResponse):
            hideIndicator()
            if let token = loginResponse.data {
                KeychainManager.shared.tokens = token
                if let vc = UIStoryboard.main.instantiateHistoryViewController() {
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                SCLAlertView().showError("Login Error", subTitle: "\(loginResponse.message ?? "Login failed")") // Error
            }

          case .failure(.objectMapping(let error as ECardError, _)):
            hideIndicator()

            SCLAlertView().showError("Login Error", subTitle: "\(error.description ?? "Login failed")") // Error


          case .failure:
            hideIndicator()

              let errorTxt = NSLocalizedString("The user name or password is incorrect.", comment: "")
            SCLAlertView().showError("Login Error", subTitle: errorTxt) // Error


          }
      }
}
