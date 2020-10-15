//
//  HistoryViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/13/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import Moya
import SCLAlertView
protocol ScanBarCodeDelegate : class {
    func onScanSuccess(data : String)
}
class HistoryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var historyManager = DataManager<PaymentApi, [PaymentItem]>()
    var paymentItems = [PaymentItem]()
    var qrId: String? = nil
    var price: String = ""
    var note: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PAYMENT HISTORY"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        tableView.dataSource = self
        tableView.delegate = self
        loadPaymentHistory()
    }
    @objc func addTapped() {
        let vc = ScannerViewController()
        qrId = nil
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func loadPaymentHistory() {
        showIndicator()
        historyManager.load(target: .loadHistory, completion: completeLoadPaymentHistory)
    }
    func completeLoadPaymentHistory(with result: Result<[PaymentItem], MoyaError>) {
        switch result {
        case .success( let paymentItems):
            hideIndicator()
            self.paymentItems = paymentItems
            tableView.reloadData()

        case.failure( let error) :
            hideIndicator()
            SCLAlertView().showError("Error", subTitle: "Can not load payment history") // Error
        }
    }
}
extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCellView.Constants.cellIdentifier, for: indexPath)as?
            HistoryCellView else {
                return HistoryCellView()
        }
        cell.initData(with: paymentItems[indexPath.row])
        return cell
    }


}
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HistoryCellView.Constants.cellHeight
    }

}
extension HistoryViewController : ScanBarCodeDelegate {
    func onScanSuccess(data: String) {
        print("on barcode return : \(data)")
        var dictonary: NSDictionary?
        if let dataJson = data.data(using: .utf8) {

             do {
                dictonary =  try JSONSerialization.jsonObject(with: dataJson, options: [.allowFragments]) as? NSDictionary

                    if let myDictionary = dictonary
                      {
                          print(" QR_ID is: \(myDictionary["QR_ID"]!)")
                        let qrID = "\(myDictionary["QR_ID"]!)"

                        let paymentInfo = "(\(myDictionary["QR_TITLE"]) \(myDictionary["QR_LOCATION"]) "
                        let amount = myDictionary["AMOUNT"] as! Float

                        if let vc = UIStoryboard.main.instantiatePaymentConfirmViewController() {
                                           vc.modalPresentationStyle = .fullScreen
                            vc.dataDic = myDictionary
                                           self.navigationController?.pushViewController(vc, animated: true)
                                       }
//                        showInfo(paymentInfo: paymentInfo, orderId: qrID, amount: amount)
                      }
                    } catch let error as NSError {

                    print(error)
                 }
        }
    }

    func showInfo(paymentInfo: String, orderId: String, amount: Float) {
        // Example of using the view to add two text fields to the alert
        // Create the subview
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )

        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)

        if amount == 0 {
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0,y: 0,width: 500,height: 350))
            let x = (subview.frame.width - 250) / 2

            let label1 = UILabel(frame: CGRect(x: x,y: 10,width: 250,height: 40))
//            textfield1.layer.borderColor = UIColor.green.cgColor
//            textfield1.layer.borderWidth = 1.5
//            textfield1.layer.cornerRadius = 5
            label1.text = paymentInfo
            label1.textAlignment = NSTextAlignment.left
            label1.addSubview(label1)


        // Add textfield 1
        let textfield1 = UITextField(frame: CGRect(x: x,y: 60,width: 250,height: 40))
            textfield1.layer.borderColor = UIColor.green.cgColor
            textfield1.layer.borderWidth = 1.5
            textfield1.layer.cornerRadius = 5
            textfield1.placeholder = "Price"
            textfield1.textAlignment = NSTextAlignment.center
            subview.addSubview(textfield1)

//        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 250,height: 40))
        textfield2.layer.borderColor = UIColor.blue.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.blue.cgColor
        textfield2.placeholder = "Note"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)

        // Add the subview to the alert's UI property
        alert.customSubview = subview
            alert.addButton("Process") {
                       print("Logged in")
                    let price = textfield1.text ?? ""
                    let note = textfield2.text ?? ""
                }
                alert.showInfo("Payment", subTitle: paymentInfo)

        } else {
            let subview = UIView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width - 10 ,height: 150))
            let x = (subview.frame.width - 250) / 2

            // Add textfield 1
            let textfield1 = UITextField(frame: CGRect(x: x,y: 10,width: 250,height: 100))
                textfield1.layer.borderColor = UIColor.green.cgColor
                textfield1.layer.borderWidth = 1.5
                textfield1.layer.cornerRadius = 5
                textfield1.placeholder = "Note"
                textfield1.textAlignment = NSTextAlignment.justified
                subview.addSubview(textfield1)
            alert.customSubview = subview



        alert.addButton("Process") {
            print("Logged in")
            let note = textfield1.text ?? ""
        }
        alert.showInfo("Payment", subTitle: paymentInfo)
        }

    }
    
}
