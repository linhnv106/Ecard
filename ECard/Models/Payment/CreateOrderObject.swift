//
//  CreateOrderObject.swift
//  ECard
//
//  Created by LinhNguyen on 10/21/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
struct CreateOrderObject: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case qrId = "QR_ID"
        case price = "Price"
        case note = "Note"

    }
    var qrId: String?
    var price: String?
    var note: String?
}
