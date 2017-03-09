//
//  OrderDetailsViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 09/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var orderId : Int32 = 0
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var items : [OrderItemsList] = []

    @IBOutlet var subView: UIView!
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var totalTaxesLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var orderDateLabel: UILabel!
    @IBOutlet var orderIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.subView.roundedGreyBorder()
        let trackOrderReqModel = TrackOrderReqModel()
        trackOrderReqModel.orderId = orderId
        let customerTrackOrderUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerOrderDetail(customerDataRequest: trackOrderReqModel,
                                              customerUserRequest: customerTrackOrderUser, customerLangCodeRequest: customerLangCode,
                                              completionHandler: {
                                            response in
                                                let orderId: Int32  = (response?.orderId)!
                                                self.orderIdLabel.text! = String(orderId)
                                                let serverdateFormatter = DateFormatter()
                                                serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                                                let strDate:String = (response?.orderDate)!
                                                let date = serverdateFormatter.date(from: strDate)
                                                
                                                let displayDateFormatter = DateFormatter()
                                                displayDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                                                let displayDate = displayDateFormatter.string(from: date!)
                                                self.orderDateLabel.text = displayDate
                                                let totalTaxes : Double = (response?.totalTaxesAndSurcharges)!
                                                self.totalTaxesLabel.text = String(totalTaxes)
                                                let totalAmount : Double = (response?.totalAmountInSAR)!
                                                self.totalAmountLabel.text = String(totalAmount)
                                                self.items = (response?.items)!
                                                self.tableView.reloadData()
                                                
                                                

                                                
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderDetailsTableViewCell
        cell.itemName.text = self.items[indexPath.row].name
        cell.itemQuantity.text = String(self.items[indexPath.row].qty)
        cell.priceLabel.text = String(self.items[indexPath.row].price)
        return cell
    }
    

    
}
