//
//  AddProductRequestModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 08/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection
public class AddProductRequestModel : EVObject
{
    var itemNameEn : String = ""
    var itemNameAr : String = ""
    var itemDescEn : String = ""
    var itemDescAr : String = ""
    var categoryId : Int = 0
    var price : Double = 0.0
    var offerText : String = ""
    
}
