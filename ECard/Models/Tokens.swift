//
//  Tokens.swift
//  AmareLife
//
//  Created by Anton Poluboiarynov on 1/16/19.
//  Copyright © 2019 Amare Global. All rights reserved.
//

struct LoginResponse: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case statusCode = "statusCode"
        case code = "code"
        case message = "message"
        case data = "data"
    }
    var success: Bool?
    var statusCode: Int?
    var code: String?
    var message: String?
    var data: Tokens?


}

struct Tokens: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case id = "id"
        case email = "email"
        case nicename = "nicename"
        case firstName = "firstName"
        case lastName = "lastName"
        case displayName = "displayName"
    }

    let token: String?
    var id: Int?
    var email: String?
    var nicename: String?
    var firstName: String?
    var lastName: String?
    var displayName: String?
}
