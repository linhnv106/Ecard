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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPaymentHistory()

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = UIStoryboard.main.instantiateDetailPaymentViewController() {
                           vc.modalPresentationStyle = .fullScreen

            vc.paymentId = "\(self.paymentItems[indexPath.row].id ??  0)"
                           self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HistoryCellView.Constants.cellHeight
    }

}

