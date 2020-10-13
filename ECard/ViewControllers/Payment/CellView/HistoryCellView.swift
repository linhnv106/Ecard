//
//  HistoryCellView.swift
//  ECard
//
//  Created by LinhNguyen on 10/13/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
class HistoryCellView: UITableViewCell {
    enum Constants {
        static let cellIdentifier = "HistoryCellView"
        static let cellHeight: CGFloat = 200.0
    }

    @IBOutlet var lblLocation: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblOrder: UILabel!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func initData(with item: PaymentItem) {
        lblDate.text = item.dateCreated ?? ""
        lblTitle.text = item.title ?? ""
        lblOrder.text = item.orderId ?? ""
        lblAddress.text = item.address ?? ""
        lblLocation.text = item.locationName ?? ""

    }
}
