//
//  DetailPaymentViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/27/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Moya
import SCLAlertView
class DetailPaymentViewController: UIViewController {

    @IBOutlet var wkWebView: WKWebView!
    @IBOutlet var addressLB: UILabel!
    @IBOutlet var timeLB: UILabel!
    @IBOutlet var qrCodeLB: UILabel!
    @IBOutlet var statusLB: UILabel!
    @IBOutlet var priceLB: UILabel!
    @IBOutlet var transactionLB: UILabel!
    @IBOutlet var customerNameLB: UILabel!

    var historyManager = DataManager<PaymentApi, PaymentItem>()
    var paymentId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết giao dịch"
        loadPaymentHistory()
    }
    func loadPaymentHistory() {
        showIndicator()
        if let id = paymentId {
        historyManager.load(target: .loadHistoryDetail(paymentId: id), completion: completeLoadPaymentHistory)
        }
    }
    func completeLoadPaymentHistory(with result: Result<PaymentItem, MoyaError>) {
        switch result {
        case .success( let paymentItem):
            hideIndicator()
            displayData(payment: paymentItem)
        case.failure( let error) :
            hideIndicator()
            SCLAlertView().showError("Error", subTitle: "Can not load payment history") // Error
        }
    }
    func displayData(payment: PaymentItem) {
        customerNameLB.text = payment.title ?? ""
        transactionLB.text = payment.vt_transaction_id ?? ""
        priceLB.text = "\(payment.price ?? "0") VND"
        statusLB.text = payment.payment_status_mgs ?? ""
        qrCodeLB.text = payment.qrName ?? ""
        timeLB.text = payment.dateCreated ?? ""
        addressLB.text = "\(payment.locationName ?? "") \(payment.address ?? "")"
        addressLB.numberOfLines = 2
        if let url = payment.map_url {
            let request = URLRequest(url: URL(string: url)!)
            wkWebView.load(request)
        }
    }
}
