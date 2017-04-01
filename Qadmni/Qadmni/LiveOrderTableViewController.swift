//
//  LiveOrderTableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 03/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LiveOrderTableViewController: UITableViewController , IndicatorInfoProvider {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var userOrderHistoryResModel : [UserOrderHistoryResModel] = []
     var orderStatusConstant = OrderStatusConstant()
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        if(userDefaultManager.getLanguageCode() == "En")
        {
       return IndicatorInfo(title: "Live orders")
        }else
        {
            return IndicatorInfo(title: "طلباتك الحين ")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let customerData = UserOrderHistoryReqModel()
        let customerUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        
         let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.userLiveOrderStatus(customerDataRequest: customerData,
                                              customerUserRequest: customerUser, customerLangCodeRequest: customerLangCode,
                                              completionHandler: {
                                                response in
                                                self.userOrderHistoryResModel = response as! [UserOrderHistoryResModel]
                                                self.tableView.reloadData()
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return userOrderHistoryResModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LiveOrderTableViewCell
        cell.subView.roundedGreyBorder()
        if (cell != nil)
        {
        cell.producerNameLabel.text = self.userOrderHistoryResModel[indexPath.row].producerBusinessName
        cell.orderIdLabel.text = String(self.userOrderHistoryResModel[indexPath.row].orderId)
        let serverdateFormatter = DateFormatter()
        serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let strDate:String = self.userOrderHistoryResModel[indexPath.row].orderDate
        let date = serverdateFormatter.date(from: strDate)
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let displayDate = displayDateFormatter.string(from: date!)
        cell.orderDatelabel.text = displayDate
        cell.paymentModeLabel.text = self.userOrderHistoryResModel[indexPath.row].paymentMode
        cell.deliveryLabel.text = self.userOrderHistoryResModel[indexPath.row].deliveryMode
        cell.amountLabel.text = String(self.userOrderHistoryResModel[indexPath.row].amountInSAR)
        cell.orderStatuslabel.text = self.userOrderHistoryResModel[indexPath.row].currentStatusCode
        cell.orderStatusLabel.text = orderStatusConstant.getValueOrderStatus(key: self.userOrderHistoryResModel[indexPath.row].currentStatusCode)
        
        if (self.userOrderHistoryResModel[indexPath.row].stageNo == 1)
        {
            cell.statusImageview.image = UIImage(named: "form_wiz_1.jpg")
        }else if (self.userOrderHistoryResModel[indexPath.row].stageNo == 2)
        {
            cell.statusImageview.image = UIImage(named: "form_wiz_2.jpg")
        }else
            {
            cell.statusImageview.image = UIImage(named: "form_wiz_3.jpg")
            }
        }
        cell.trackOrderButtonOutlet.tag = indexPath.row
        cell.trackOrderButtonOutlet.addTarget(self, action:#selector(trackOrderButton(sender:)), for: .touchUpInside)
        
        cell.feedbackButtonOutlet.tag = indexPath.row
        cell.feedbackButtonOutlet.addTarget(self, action:#selector(feedbackButton(sender:)), for: .touchUpInside)
        

        return cell
    }
    
    func trackOrderButton(sender : UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: TrackOrderViewController = storyboard.instantiateViewController(withIdentifier: "TrackOrderViewController") as! TrackOrderViewController
        vc.orderId = self.userOrderHistoryResModel[sender.tag].orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func feedbackButton(sender : UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UserFeedbackViewController = storyboard.instantiateViewController(withIdentifier: "UserFeedbackViewController") as! UserFeedbackViewController
        vc.orderId = self.userOrderHistoryResModel[sender.tag].orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
