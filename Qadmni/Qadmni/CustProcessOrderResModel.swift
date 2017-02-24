//
//  CustProcessOrderResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 21/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustProcessOrderResModel : CustomerBaseResponseModel
{
    var orderId : Int32 = 0
    var transactionRequired : Bool = false
    var transactionId : String = ""
    var amount : Double = 0
    var currency : String = ""
    var paypalEnvValues : PayPalInfoResModel = PayPalInfoResModel()
}
