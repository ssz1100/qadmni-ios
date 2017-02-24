//
//  VendorLoginResponseModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 01/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorLoginResponseModel : BaseResponseModel
{
    var producerId : Int32 = 0
    var producerName : String = ""
    var businessNameEn : String = ""
    var businessNameAr : String = ""
    var businessAddress : String = ""
    var businessLat : Double = 0
    var businessLong : Double = 0
    var emailId : String = ""
    var password : String = ""

}
