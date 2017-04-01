//
//  OrderStatusConstant.swift
//  Qadmni
//
//  Created by Prakash Sabale on 29/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
public class OrderStatusConstant
{
    var readyToPickUp : String = "READY_TO_PICKUP"
    var pickUpComplete : String = "PICKUP_COMPLETE"
    var timeForPickUpOver : String = "TIME_FOR_PICKUP_OVER"
    var orderPlacedCode : String = "ORDER_PLACED_CODE"
    var deliveryInProgress : String = "DELIVERY_IN_PROGRESS"
    
    var orderStatusDictionary : [String:String] = ["ORDER_PLACED":NSLocalizedString("Orderhasbeenplaced", comment: ""),
                                                   "DELIVERY_IN_PROGRESS":NSLocalizedString("Deliveryinprogress", comment: ""),
                                                   "DELIVERED":NSLocalizedString("Delivered", comment: ""),
                                                   "ORDER_PLACED_CODE":NSLocalizedString("Orderplaced", comment: ""),
                                                   "READY_TO_PICKUP":NSLocalizedString("Readytopickup", comment: ""),
                                                   "PICKUP_COMPLETE":NSLocalizedString("Orderpickupcomplete", comment: ""),
                                                   "TIME_FOR_PICKUP_OVER":NSLocalizedString("Timeforpickupisover", comment: "")]
   
    public func getValueOrderStatus(key : String) -> String
    {
        return orderStatusDictionary[key]!
    }
    

}
