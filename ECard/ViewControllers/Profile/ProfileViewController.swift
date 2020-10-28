//
//  ProfileViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/21/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
class ProfileViewController: UIViewController {
    var userInfo: UserInfo?

    @IBOutlet var phoneLb: UILabel!
    @IBOutlet var fullNameLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        let button = UIBarButtonItem(title: "Thay đổi", style: .plain, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItem = button

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProfile()
    }

    @objc func addTapped() {
        if let vc = UIStoryboard.main.instantiateUpdateProfileViewController() {
                           vc.modalPresentationStyle = .fullScreen
            vc.userInfo = userInfo
                           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getProfile() {
        showIndicator()
        let dataManager = DataManager<ProfileApi, UserInfo>()
        dataManager.load(target: .getProfile){ result in
            switch result {
            case .success(let userInfo):
                self.hideIndicator()
                self.userInfo = userInfo
                self.displayInfo()
                break;
            case .failure(let error):
                self.hideIndicator()
                SCLAlertView().showError("Lỗi", subTitle: "\(error.errorDescription)")

                break;
            }

        }
    }
    func displayInfo(){
        if let user = userInfo {
            fullNameLb.text = "\(user.lastName!) \(user.firstName!)"
            phoneLb.text = user.phone
        }

    }
}
