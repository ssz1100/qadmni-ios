//
//  CustConfirmOrderReqModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 21/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustConfirmOrderReqModel : EVObject
{
    var orderId : Int32 = 0
    var transactionId : String = ""
    var amountInSAR : Double = 0
    var amountInUSD : Double = 0
    var paypalId : String = ""

}
