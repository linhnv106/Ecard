//
//  OrderStatus.swift
//  ECard
//
//  Created by LinhNguyen on 10/15/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
struct OrderStatus: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case code = "code"
        case message = "message"
        
    }
    var orderId: String?
    var code: Int?
    var message: String?
}
