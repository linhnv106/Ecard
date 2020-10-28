//
//  ProfileApi.swift
//  ECard
//
//  Created by LinhNguyen on 10/27/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import Moya
enum ProfileApi {
    case getProfile
    case updateProfile(userInfo: UserInfo)
}
extension ProfileApi : TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
           return .bearer
       }
       var baseURL: URL {
           return KeychainManager.shared.baseURL
       }

       var path: String {
          switch self {
          case .getProfile:
              return "/v2/profile"

          case .updateProfile:
              return "v2/user-update"


          }
       }

       var method: Moya.Method {
           switch self {
           case .getProfile:
              return .get

           case .updateProfile:
              return .post

           }

      }

       var sampleData: Data {
           return Data()
       }

       var task: Task {
          switch self {
          case .getProfile:
              return .requestPlain


          case .updateProfile(let userProfile):
              return .requestJSONEncodable(userProfile)
          }
       }

       var headers: [String: String]? {
          return ["Content-type": "application/json; charset=utf-8"]
       }


  }
