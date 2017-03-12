//
//  LoginVendorRequestModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 01/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class LoginVendorRequestModel : EVObject
{
    var emailId : String = ""
    var password : String = ""
    var pushNotificationId : String?
    var pushDeviceOsType : String = "IO"

}
