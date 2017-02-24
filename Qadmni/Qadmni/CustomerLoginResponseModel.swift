//
//  CustomerLoginResponseModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 14/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class CustomerLoginResponseModel : CustomerBaseResponseModel
{
    var customerId : Int32 = 0
    var name : String = ""
    var phone : String = ""
    var emailId : String = ""
    var password : String = ""

}
