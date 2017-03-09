//
//  TrackOrderResModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 09/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection
public class TrackOrderResModel:CustomerBaseResponseModel
{
    var orderId : Int32 = 0
    var deliveryAddress : String = ""
    var timeRequiredInMinutes : String = ""
    var stageNo : Int = 0
    var currentStatusCode : String = ""
    var deliveryStatus : String = ""
    var deliveryMode : String = ""
}
