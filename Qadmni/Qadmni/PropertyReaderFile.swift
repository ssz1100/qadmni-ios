//
//  PropertyReaderFile.swift
//  Qadmni
//
//  Created by Prakash Sabale on 01/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation

public class PropertyReaderFile
{
    public class func getBaseUrl() -> String
    {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseUrl")
        
        return baseUrl as! String
        
    }
}
