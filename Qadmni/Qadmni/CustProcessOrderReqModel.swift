//
//  CustProcessOrderReqModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 21/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustProcessOrderReqModel : EVObject
{
    var orderId : Int32 = 0
    var orderAmountInSAR : Double = 0
    var orderAmountInUSD : Double = 0

}
