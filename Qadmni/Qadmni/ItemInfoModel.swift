//
//  ItemInfoModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class ItemInfoModel : EVObject
{
    var itemId :Int32 = 0
    var itemDesc : String = ""
    var itemName : String = ""
    var unitPrice : Double = 0
    var offerText : String = ""
    var rating : String = ""
    var imageUrl : String = ""
    var producerId : Int32 = 0

}
