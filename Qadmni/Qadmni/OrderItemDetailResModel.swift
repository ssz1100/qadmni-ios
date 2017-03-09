//
//  OrderItemDetailResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 09/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection
public class OrderItemDetailResModel : CustomerBaseResponseModel
{
    var orderId : Int32 = 0
    var orderDate : String = ""
    var items : [OrderItemsList] = []
    var totalAmountInSAR : Double = 0
    var totalTaxesAndSurcharges : Double = 0
    
}


