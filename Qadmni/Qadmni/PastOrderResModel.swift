//
//  PastOrderResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 03/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection
public class PastOrderResModel : CustomerBaseResponseModel
{
    var orderId : Int32 = 0
    var orderDate : String = ""
    var producerBusinessName : String = ""
    var paymentMode : String = ""
    var deliveryMode : String = ""
    var amountInSAR : Double = 0
    var deliveryStatus : String = ""
    var deliveryStatusCode : Int = 0
}
