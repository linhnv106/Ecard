//
//  CreatedOrder.swift
//  ECard
//
//  Created by LinhNguyen on 10/15/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
struct CreatedOrder: Equatable, Codable {
    enum CodingKeys: String,CodingKey {
        case checkSum = "checksum_data"
        case url = "url"
        case orderId = "order_id"
        case code = "code"
        case message = "message"
    }
    var checkSum: String?
    var url: String?
    var orderId: String?
    var code: Int?
    var message: String?
}
