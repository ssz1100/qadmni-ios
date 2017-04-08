//
//  CustPlaceOrderResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustPlaceOrderResModel : CustomerBaseResponseModel
{
    var orderId : Int32 = 0
    var orderedItems : [CustOrderedItemResModel] = []
    //var chargeBreakup : [CustChargeBreakupResModel] = []
    var totalAmountInSAR : Double = 0
    var totalAmountInUSD : Double = 0
    
}
