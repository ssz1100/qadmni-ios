//
//  VendorOrderResponseModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 23/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorOrderResponseModel : BaseResponseModel
{
    var orderId : Int32 = 0
    var orderDate : String = ""
    var scheduleDate : String = ""
    var paymentMode : String = ""
    var paymentMethod : String = ""
    var deliveryMethod : String = ""
    var deliveryType : String = ""
    var customerName : String = ""
    var customerPhone : String = ""
    var deliveryAddress : String = ""
    var deliveryLat : Double = 0
    var deliveryLong : Double = 0
    var amountInSAR : Double = 0
    var stageNo : Int = 0
    var currentStatusCode : String = ""
    var deliveryStatusId : Int = 0
    var updatableStatusCodes : [UpdateStatusModel] = []
    var canUpdateStatus : Bool = false
    var isGitWrap : Bool = false
    var giftMessage : String = ""
  
}
