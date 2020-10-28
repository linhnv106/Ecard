//
//  UserInfo.swift
//  ECard
//
//  Created by LinhNguyen on 10/27/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
struct UserInfo: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case phone = "user_phone"
        case email = "user_email"
        case firstName = "firstname"
        case lastName = "lastname"
    }
    var userName: String?
    var phone : String?
    var email: String?
    var firstName: String?
    var lastName: String?
}
