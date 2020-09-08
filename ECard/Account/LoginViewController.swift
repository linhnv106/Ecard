//
//  LoginViewController.swift
//  ECard
//
//  Created by LinhNguyen on 9/4/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
class LoginViewController: UIViewController {
    @IBOutlet var userNameLB: UITextField!

    @IBOutlet var pwdLB: UITextField!

    @IBOutlet var loginBtn: UIButton!

    @IBOutlet var registerLB: UILabel!

    @IBAction func didTapLoginButton(_ sender: Any) {
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTegister))
        registerLB.isUserInteractionEnabled = true
        registerLB.addGestureRecognizer(tap)
    }
    @objc func didTapTegister(sender: UITapGestureRecognizer) {
        print("tap working")
        if let vc = UIStoryboard.main.instantiateRegister() {
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
