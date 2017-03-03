//
//  UserDefaultManager.swift
//  Qadmni
//
//  Created by Prakash Sabale on 08/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation


public class UserDefaultManager
{
    let userDefaults = UserDefaults.standard
    
    public func saveVendorData(vendorResponse : VendorLoginResponseModel?)
    {
        
        userDefaults.setValue(vendorResponse?.producerId, forKey: "vendorproducerId")
        userDefaults.setValue(vendorResponse?.producerName, forKey: "vendorproducerName")
        userDefaults.setValue(vendorResponse?.businessNameEn, forKey: "vendorBusinessNameEn")
        userDefaults.setValue(vendorResponse?.businessNameAr, forKey: "vendorBusinessNameAr")
        userDefaults.setValue(vendorResponse?.businessAddress, forKey: "vendorBusinessAddress")
        userDefaults.setValue(vendorResponse?.businessLat, forKey: "vendorBusinessLat")
        userDefaults.setValue(vendorResponse?.businessLong, forKey: "vendorBusinessLong")
        userDefaults.setValue(vendorResponse?.emailId, forKey: "vendorEmailId")
        userDefaults.setValue(vendorResponse?.password, forKey: "vendorPassword")
        userDefaults.setValue("vendor", forKey: "userType")
        userDefaults.synchronize()
     
    }
    
    public func getVendorDetailClear ()
    {
        userDefaults.setValue(nil, forKey: "vendorproducerId")
        userDefaults.setValue(nil, forKey: "vendorproducerName")
        userDefaults.setValue(nil, forKey: "vendorBusinessNameEn")
        userDefaults.setValue(nil, forKey: "vendorBusinessNameAr")
        userDefaults.setValue(nil, forKey: "vendorBusinessAddress")
        userDefaults.setValue(nil, forKey: "vendorBusinessLat")
        userDefaults.setValue(nil, forKey: "vendorBusinessLong")
        userDefaults.setValue(nil, forKey: "vendorEmailId")
        userDefaults.setValue(nil, forKey: "vendorPassword")
        userDefaults.setValue("other", forKey: "userType")
        userDefaults.synchronize()

    }
    public func getVendorDetail()-> VendorUserRequestModel
    {
        let vendorUserRequest: VendorUserRequestModel = VendorUserRequestModel()
        vendorUserRequest.producerId = userDefaults.value(forKeyPath: "vendorproducerId") as! Int32
        vendorUserRequest.password = userDefaults.value(forKeyPath: "vendorPassword") as! String
        
        return vendorUserRequest
        
    }
    
        
    public func getVendorImageDetail()-> AddProductImageRequestModel
    {
        let addProductImageRequest: AddProductImageRequestModel = AddProductImageRequestModel()
        addProductImageRequest.producerId = userDefaults.value(forKeyPath: "vendorproducerId") as! Int32
        addProductImageRequest.password = userDefaults.value(forKeyPath: "vendorPassword") as! String
        
        return addProductImageRequest
        
    }
    
    public func saveCustomerData(customerResponse : CustomerLoginResponseModel?)
    {
        userDefaults.setValue(customerResponse?.customerId, forKey: "customerId")
        userDefaults.setValue(customerResponse?.name, forKey: "customername")
        userDefaults.setValue(customerResponse?.phone, forKey: "customerphone")
        userDefaults.setValue(customerResponse?.emailId, forKey: "customerEmailId")
        userDefaults.setValue(customerResponse?.password, forKey: "customerPassword")
        userDefaults.setValue("customer", forKey: "userType")
        userDefaults.synchronize()
    
    }
    
    public func getUserDetailClear()
    {
        userDefaults.setValue(nil, forKey: "customerId")
        userDefaults.setValue(nil, forKey: "customername")
        userDefaults.setValue(nil, forKey: "customerphone")
        userDefaults.setValue(nil, forKey: "customerEmailId")
        userDefaults.setValue(nil, forKey: "customerPassword")
        userDefaults.setValue("other", forKey: "userType")
        userDefaults.synchronize()

    }
    
    public func getCustomerCredential() -> CustomerUserRequestModel
    {
        let customerUserRequestModel: CustomerUserRequestModel = CustomerUserRequestModel()
        customerUserRequestModel.customerId = userDefaults.value(forKey: "customerId") as! Int32
        customerUserRequestModel.password = userDefaults.value(forKey: "customerPassword") as! String
        
        return customerUserRequestModel
    
    }
    
    public func getUserType() -> String
    {
        if(userDefaults.value(forKey: "userType") == nil)
        {
            userDefaults.setValue("other", forKey: "userType")
        }
        var userType : String = ""
         userType = userDefaults.value(forKey: "userType") as! String
        
        return userType
    }
    
   
    

}
