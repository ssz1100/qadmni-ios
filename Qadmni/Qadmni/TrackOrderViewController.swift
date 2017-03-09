//
//  TrackOrderViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 09/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class TrackOrderViewController: UIViewController {
    var orderId : Int32 = 0
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    @IBOutlet var orderIdlabel: UILabel!
    @IBOutlet var trackOrderImageview: UIImageView!
    @IBOutlet var deliveryAddress: UILabel!
    @IBOutlet var orderStatus: UILabel!
    @IBOutlet var subView: UIView!
    @IBAction func orderDetailButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: OrderDetailsViewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        vc.orderId = orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.subView.roundedGreyBorder()
        let trackOrderReqModel = TrackOrderReqModel()
        trackOrderReqModel.orderId = orderId
        let customerTrackOrderUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerTrackOrder(customerDataRequest: trackOrderReqModel,
                                             customerUserRequest: customerTrackOrderUser,
                                             customerLangCodeRequest: customerLangCode,
                                             completionHandler: {
                                                response in
                                                 let orderId: Int32  = (response?.orderId)!
                                                self.orderIdlabel.text = String(orderId)
                                                self.deliveryAddress.text = response?.deliveryAddress
                                                if (response?.stageNo == 1)
                                                {
                                                self.trackOrderImageview.image = UIImage(named: "form_wiz_1.jpg")
                                                }
                                                else if (response?.stageNo == 2){
                                                self.trackOrderImageview.image = UIImage(named: "form_wiz_2.jpg")
                                                }else{
                                                self.trackOrderImageview.image = UIImage(named: "form_wiz_3.jpg")
                                                }
        })
        

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
