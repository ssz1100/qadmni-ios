//
//  VendorOrderStatusTableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 30/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorOrderStatusTableViewController: UITableViewController {
    var vendorOrderResponseModel : [VendorOrderResponseModel] = []
    var userDefaultManager : UserDefaultManager = UserDefaultManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vendorOrderUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let vendorOrderData = VendorOrderReqModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorOrder(vendorDataRequest: vendorOrderData,
                                  vendorUserRequest: vendorOrderUser,
                                  vendorLangCodeRequest: vendorLangCode,
                                  completionHandler:{
                                        response in
                                    self.vendorOrderResponseModel = response as! [VendorOrderResponseModel]
                                    self.tableView.reloadData()

        })
        
        
        

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vendorOrderResponseModel.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> VendorOrderStatusTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VendorOrderStatusTableViewCell
        cell.subView.roundedGreyBorder()
        let orderIdString: String = String(self.vendorOrderResponseModel[indexPath.row].orderId)
        cell.orderIdLabel.text = orderIdString
        cell.customerNameLabel.text = self.vendorOrderResponseModel[indexPath.row].customerName
        cell.paymentModeLabel.text = self.vendorOrderResponseModel[indexPath.row].paymentMethod
        cell.deleiveryTypeLabel.text = self.vendorOrderResponseModel[indexPath.row].deliveryType
        let amountString : String = String(self.vendorOrderResponseModel[indexPath.row].amountInSAR)
        cell.amountLabel.text = amountString
        
        let serverdateFormatter = DateFormatter()
        serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let strDate:String = self.vendorOrderResponseModel[indexPath.row].orderDate
        let date = serverdateFormatter.date(from: strDate)
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let displayDate = displayDateFormatter.string(from: date!)
        cell.orderDateLabel.text = displayDate

        
        if (self.vendorOrderResponseModel[indexPath.row].isGitWrap == false)
        {
        cell.giftMessageVIew.removeFromSuperview()
        }
        else{
        cell.giftMessageLabel.text = self.vendorOrderResponseModel[indexPath.row].giftMessage
        }
               return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: VendorOrderDetailsViewController = storyboard.instantiateViewController(withIdentifier: "VendorOrderDetailsViewController") as! VendorOrderDetailsViewController
        vc.vendorOrderResponseModel = self.vendorOrderResponseModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
