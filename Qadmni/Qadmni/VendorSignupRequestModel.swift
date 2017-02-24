//
//  VendorSignupRequestModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 07/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class VendorSignupRequestModel : EVObject
{
    var producerName : String = ""
    var emailId : String = ""
    var password : String = ""
    var businessNameEn : String = ""
    var businessNameAr : String = ""
    var businessAddress : String = ""
    var businessLat : Double = 0.0
    var businessLong : Double = 0.0
    var pushNotificationId : String = ""
    var osVersionType : String = "Io"


}
