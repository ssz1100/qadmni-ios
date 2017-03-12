//
//  CustomerLoginRequestModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 14/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustomerLoginRequestModel : EVObject
{
    var emailId : String = ""
    var password : String = ""
    var pushId : String? 
    var osVersionType : String = "IO"

}
