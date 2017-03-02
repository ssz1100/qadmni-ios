//
//  VendorUpdateProductReqModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 02/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorUpdateProductReqModel : EVObject
{
    var productId : Int32 = 0
    var itemNameEn : String = ""
    var itemNameAr : String = ""
    var itemDescEn : String = ""
    var itemDescAr : String = ""
    var categoryId : Int = 0
    var price : Double = 0.0
    var offerText : String = ""
    var isActive : Int = 0
    
}
