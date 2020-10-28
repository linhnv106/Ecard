//
//  DashboardViewController.swift
//  ECard
//
//  Created by LinhNguyen on 10/21/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
class DashboardViewController: UIViewController {
    var qrId: String? = nil
    var price: String = ""
    var note: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trang chủ"
        let image = UIImage(named: "qr")?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItem = button
      
    }

    @objc func addTapped() {
        let vc = ScannerViewController()
        qrId = nil
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion:nil)

    }
}
extension DashboardViewController : ScanBarCodeDelegate {
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
                      }
                    } catch let error as NSError {

                    print(error)
                 }
        }
    }



}
