//
//  PaymentItem.swift
//  ECard
//
//  Created by LinhNguyen on 10/13/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
struct PaymentItem: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case dateCreated = "date_created"
        case qrName = "qr_name"
        case locationName = "location_name"
        case orderId = "order_id"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
    }
    var id: Int?
    var title: String?
    var price: String?
    var dateCreated : String?
    var qrName: String?
    var locationName: String?
    var orderId: String?
    var address: String?
    var lat: String?
    var lng: String?
}
