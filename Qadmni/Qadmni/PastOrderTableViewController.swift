//
//  PastOrderTableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 03/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PastOrderTableViewController: UITableViewController , IndicatorInfoProvider {
     var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var pastOrderResModel : [PastOrderResModel] = []
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        return IndicatorInfo(title: "Past order")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let customerData = UserOrderHistoryReqModel()
        let customerUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.userPastOrderStatus(customerDataRequest: customerData,
                                              customerUserRequest: customerUser,
                                              customerLangCodeRequest: customerLangCode,
                                              completionHandler: {
                                                response in
                                                self.pastOrderResModel = response as! [PastOrderResModel]
                                                self.tableView.reloadData()
        })

           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pastOrderResModel.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PastOrderTableViewCell
        cell.subView.roundedGreyBorder()
        
        cell.orderIdLabel.text = String(self.pastOrderResModel[indexPath.row].orderId)
        let serverdateFormatter = DateFormatter()
        serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let strDate:String = self.pastOrderResModel[indexPath.row].orderDate
        let date = serverdateFormatter.date(from: strDate)
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let displayDate = displayDateFormatter.string(from: date!)
        cell.orderDateLabel.text = displayDate
        
        cell.amountLabel.text = String(self.pastOrderResModel[indexPath.row].amountInSAR)
        cell.statusLabel.text = self.pastOrderResModel[indexPath.row].deliveryStatus
        cell.statusImageview.image = UIImage(named: "form_wiz_3.jpg")
       
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
