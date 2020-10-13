//
//  Credentials.swift
//  AmareLife
//
//  Created by Anton Poluboiarynov on 1/16/19.
//  Copyright © 2019 Amare Global. All rights reserved.
//

import Moya

struct Credentials {
    let email: String
    let password: String
}

extension Credentials: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .none
    }
    var baseURL: URL {
        return KeychainManager.shared.baseURL
    }
    
    var path: String {
        return "/token"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["username": self.email,
                                               "password": self.password],
                                  encoding: URLEncoding.httpBody)
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/x-www-form-urlencoded"]
    }
}
