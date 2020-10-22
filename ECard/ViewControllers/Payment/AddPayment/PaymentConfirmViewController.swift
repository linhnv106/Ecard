//
//  PaymentConfirmViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/14/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import Moya
class PaymentConfirmViewController: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var tvNote: UITextView!

    @IBOutlet var processBtn: UIButton!
    @IBOutlet var tfAmount: UITextField!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblAdress: UILabel!
    var openPayment = false
    var dataDic: NSDictionary?
    var order : CreatedOrder?
    var dataManager = DataManager<PaymentApi, CreatedOrder>()

    @IBAction func didTapProcess(_ sender: Any) {
        showIndicator()
        let qrId = "\((dataDic?["QR_ID"] as? Int)!)"
        var price : String = ""
        if let amount = dataDic?["AMOUNT"] as? Float {
            if amount > 0 {
                price = "\(amount)"
            }
        }
        if price.isEmpty {
            price = tfAmount.text ?? ""
        }
        if price.isEmpty {
             SCLAlertView().showError("Payment Error", subTitle: "Please input price!") // Error
            return
        }
        let note = tvNote.text ?? ""
        dataManager.load(target: .getCreateOrder(qrId: qrId ?? "", price: price, note: note), completion: completeGetOrder)


    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
     @objc func checkOrderStatus(){
        if openPayment {
            checkOrder()
            openPayment = false
        }
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(checkOrderStatus), name: UIApplication.willEnterForegroundNotification, object: nil)

        title = "PAYMENT PROCESS"
        if let data = dataDic {
            if let title = data["QR_TITLE"] as? String {
                lblTitle.text = title
            }
            if let location = data["QR_LOCATION"] as? String {
                lblLocation.text = location
            }
            if let amount = data["AMOUNT"] as? Float {
                if amount > 0 {
                    lblAmount.text = "\(amount) VND"
                    tfAmount.isHidden = true
                } else {
                    lblAmount.text = ""
                    tfAmount.isHidden = false
                    lblAmount.isHidden = true
                }
            }


        }
        processBtn.layer.cornerRadius = 8
        processBtn.layer.masksToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func completeGetOrder(with result: Result<CreatedOrder, MoyaError>) {
        switch result {
        case .success( let newOrder):
            hideIndicator()
            print("\(newOrder)")
            order = newOrder
            if let urlString = newOrder.url {
                 let url = URL(string: urlString)
                if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                    let url = URL(string: encoded)
                {
                    openPayment = true
                    UIApplication.shared.open(url)
                }



            }
        case.failure( let error) :
            hideIndicator()
            openPayment = false
            SCLAlertView().showError("Error", subTitle: "Can not create new Order") // Error
        }
    }
    func checkOrder() {
        if let orderId = order?.orderId {
            showIndicator()
            let dataManager = DataManager<PaymentApi, OrderStatus>()
            dataManager.load(target: .checkOrderStatus(orderId: orderId), completion: completeGetOrderStatus)
        }

    }
    func completeGetOrderStatus(with result: Result<OrderStatus, MoyaError>) {
        switch result {
        case .success( let orderStatus):
            hideIndicator()
            if let code = orderStatus.code, code == 200 {

                let alertView = SCLAlertView()

//                alertView.addButton("Done") {
//                    self.navigationController?.popViewController(animated: true)
//                    print("Second button tapped")
//                }
                alertView.showSuccess("Success", subTitle: "\(orderStatus.message ?? "Payment Sucessful!")")

                    return
                }
            SCLAlertView().showError("Error", subTitle: "Order Status: \(orderStatus.message ?? "")") // Error


        case.failure( let error) :
            hideIndicator()
            SCLAlertView().showError("Error", subTitle: "Can not create new Order") // Error
        }
    }
}

