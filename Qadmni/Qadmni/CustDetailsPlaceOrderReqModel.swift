//
//  CustDetailsPlaceOrderReqModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 18/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustDetailsPlaceOrderReqModel: EVObject
{
    var productInfo : [ItemRequestModel] = []
    var deliveryAddress : String = ""
    var deliveryLat : Double = 0
     var deliveryLong : Double = 0
    var deliveryMethod : String = ""
    var deliverySchedule : Int32 = 0
    var paymentMethod : String = ""
    var isGift: Bool = false
    var giftMessage : String = ""
}
