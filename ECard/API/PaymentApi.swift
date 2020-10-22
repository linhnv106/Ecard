//
//  PaymentApi.swift
//  ECard
//
//  Created by LinhNguyen on 9/4/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import Moya
enum PaymentApi {
    case loadHistory
    case checkOrderStatus(orderId : String)
    case getCreateOrder(qrId: String, price: String, note: String)

}
extension PaymentApi: TargetType, AccessTokenAuthorizable {
  var authorizationType: AuthorizationType? {
         return .bearer
     }
     var baseURL: URL {
         return KeychainManager.shared.baseURL
     }

     var path: String {
        switch self {
        case .loadHistory:
            return "/v2/my-history"

        case .getCreateOrder:
            return "/v2/getOrder"
        case .checkOrderStatus:
            return "/v2/checkOrder"

        }
     }

     var method: Moya.Method {
         switch self {
         case .loadHistory:
            return .get

         case .getCreateOrder,.checkOrderStatus:
            return .post

         }

    }

     var sampleData: Data {
         return Data()
     }

     var task: Task {
        switch self {
        case .loadHistory:
            return .requestPlain

        case .getCreateOrder(let qrId,  let price, let note):
            let createOrder = CreateOrderObject(qrId: qrId, price: price, note: note)
            return .requestJSONEncodable(createOrder)
        case .checkOrderStatus(let orderId) :
            let orderStatus = OrderStatus(orderId: orderId, code: 0, message: "")
            return .requestJSONEncodable(orderStatus)
        }
     }

     var headers: [String: String]? {
        return ["Content-type": "application/json; charset=utf-8"]
     }
    
    
}
