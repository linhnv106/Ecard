//
//  UpdateProfileViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/27/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
class UpdateProfileViewController: UIViewController {

    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var updateButton: UIButton!
    var userInfo: UserInfo?
    @IBAction func didTapUpdate(_ sender: Any) {
        if let phoneNum = phoneTF.text {
            userInfo?.phone = phoneNum
        } else {
            SCLAlertView().showError("Lỗi", subTitle: "Vui lòng nhập số điện thoại!")
            return
        }
        if let firstName = firstNameTF.text {
            userInfo?.firstName = firstName
        }else {
            SCLAlertView().showError("Lỗi", subTitle: "Vui lòng nhập tên!")
            return
        }
        if let lastName = lastNameTF.text {
            userInfo?.lastName = lastName
        }else {
            SCLAlertView().showError("Lỗi", subTitle: "Vui lòng nhập họ!")
            return
        }
        updateProfile()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thay đổi thông tin"
        if let user = userInfo {
            phoneTF.text = user.phone!
            lastNameTF.text = user.lastName!
            firstNameTF.text = user.firstName!
        }
    }
    func updateProfile() {
        showIndicator()
        let dataManager = DataManager<ProfileApi, UserInfo>()
        dataManager.load(target: .updateProfile(userInfo: userInfo!)){ result in
            switch result {
            case .success(let userInfo):
                self.hideIndicator()
                self.navigationController?.popViewController(animated: true)
                break;
            case .failure(let error):
                self.hideIndicator()
                SCLAlertView().showError("Lỗi", subTitle: "\(error.errorDescription)")

                break;
            }

        }

        
    }

}
