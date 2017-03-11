//
//  SubmitFeebackDataReqModel.swift
//  Qadmni
//
//  Created by Prakash Sabale on 11/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import EVReflection
public class SubmitFeebackDataReqModel : EVObject
{
    var orderId : Int32 = 0
    var items : [SubmitFeedbackItemModel] = []
}
