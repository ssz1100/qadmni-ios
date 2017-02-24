//
//  VendorItemResponseModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 08/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorItemResponseModel : BaseResponseModel
{
    var itemId : Int32 = 0
    var itemName : String = ""
    var  itemDesc : String = ""
    var imageUrl : String = ""
    var price : Double = 0.0
    var category : String = ""
    var availableForSale : Int = 1
}
