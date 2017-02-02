//
//  BaseResponseModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 01/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection

public class BaseResponseModel :EVObject
{
    var errorCode: Int32 = 0
    var message : String = ""
    var data : String = ""

}
