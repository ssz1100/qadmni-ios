//
//  VendorItemDetailResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 02/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorItemDetailResModel : BaseResponseModel
{   var itemId : Int32 = 0
    var itemNameEn : String = ""
    var itemNameAr : String = ""
    var itemDescEn : String = ""
    var itemDescAr : String = ""
    var categoryId : Int = 0
    var unitPrice : Double = 0.0
    var offerText : String = ""
    var isActive : Int = 0
    var imageUrl : String = ""
}

