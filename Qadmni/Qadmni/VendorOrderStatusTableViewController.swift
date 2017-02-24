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
        if (self.vendorOrderResponseModel[indexPath.row].isGitWrap == false)
        {
        cell.giftMessageVIew.removeFromSuperview()
        }
        else{
        cell.giftMessageLabel.text = self.vendorOrderResponseModel[indexPath.row].giftMessage
        }
        
        
        

        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
