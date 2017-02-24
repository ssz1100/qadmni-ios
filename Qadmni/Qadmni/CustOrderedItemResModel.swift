//
//  CustOrderedItemResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustOrderedItemResModel : EVObject
{
    var unitPrice: Double = 0
    var itemTotalPrice : Double = 0
    var itemName : String = ""
    var producerId : Int32 = 0
    var itemId : Int32 = 0
    var itemQty : Int32 = 0
}
