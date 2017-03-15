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
    
    func getSelectedSortBy() -> Int
    {
        var selectedSort : Int = 0
        if(userDefaults.value(forKey: "selectedSortBy") == nil)
        {
            userDefaults.setValue(0, forKey: "selectedSortBy")
        }
        selectedSort = userDefaults.value(forKey: "selectedSortBy") as! Int
        
        return selectedSort
           
    }
    func setSelectedSortBy(selectedSort : Int)
    {
        userDefaults.setValue(selectedSort, forKey: "selectedSortBy")
    
    }
    
    func getFiltertedByDistance() -> Double
    {
        var filterByDistance : Double = 0
        if(userDefaults.value(forKey: "filterByDistance") == nil)
        {
            userDefaults.setValue(0, forKey: "filterByDistance")
        }
        filterByDistance = userDefaults.value(forKey: "filterByDistance") as! Double
        
        return filterByDistance

    }
    func setFiltertedByDistance(filterByDistance : Double)
    {
        userDefaults.setValue(filterByDistance, forKey: "filterByDistance")
        
    }
    
    func getFiltertedByPrice() -> Double
    {
        var filterByPrice : Double = 0
        if(userDefaults.value(forKey: "filterByPrice") == nil)
        {
            userDefaults.setValue(0, forKey: "filterByPrice")
        }
        filterByPrice = userDefaults.value(forKey: "filterByPrice") as! Double
        
        return filterByPrice
        
    }
    func setFiltertedByPrice(filterByPrice : Double)
    {
        userDefaults.setValue(filterByPrice, forKey: "filterByPrice")
        
    }
    func getUserProfiledetail()-> UserProfileDetail
    {
        let userProfile = UserProfileDetail()
        userProfile.name = userDefaults.value(forKey: "customername") as! String
         userProfile.email = userDefaults.value(forKey: "customerEmailId") as! String
         userProfile.password = userDefaults.value(forKey: "customerPassword") as! String
         userProfile.phoneNumber = userDefaults.value(forKey: "customerphone") as! String
        return userProfile
}
    func saveUpdatedCustomerDetails(updateProfile : UserProfileDetail)
    {
         userDefaults.setValue(updateProfile.name, forKey: "customername")
        userDefaults.setValue(updateProfile.password, forKey: "customerPassword")
        userDefaults.setValue(updateProfile.phoneNumber, forKey: "customerphone")
        
    }
    func getVendorProfiledetail()-> VendorProfileDetail
    {
        let vendorProfile = VendorProfileDetail()
        vendorProfile.name = userDefaults.value(forKey: "vendorproducerName") as! String
        vendorProfile.email = userDefaults.value(forKey: "vendorEmailId") as! String
        vendorProfile.password = userDefaults.value(forKey: "vendorPassword") as! String
        return vendorProfile
    }
    func saveUpdatedVendorDetails(updateVendorProfile : VendorProfileDetail)
    {
        userDefaults.setValue(updateVendorProfile.name, forKey: "vendorproducerName")
        userDefaults.setValue(updateVendorProfile.password, forKey: "vendorPassword")
        
    }
    func getLanguageCode() -> String
    {
        var languageCode : String = GlobalConstants.englishCode
        var langCode = userDefaults.value(forKey: "LanguageCode") as? String
        if(langCode != nil && langCode != ""){
            languageCode = langCode!
        }
        //languageCode = userDefaults.value(forKey: "LanguageCode") as! String
        
        print(languageCode)
        return languageCode
        
    }
    func setLanguageCode(languageCode : String)
    {
        userDefaults.setValue(languageCode, forKey: "LanguageCode")
        //LanguageManager.sharedInstance.setLocale(languageCode)

    }
    func getVendorname()-> String
    {
        if(userDefaults.value(forKey: "vendorproducerName") == nil)
        {
            userDefaults.setValue("", forKey: "vendorproducerName")
        }
        var vendorName : String = ""
        vendorName = userDefaults.value(forKey: "vendorproducerName") as! String
        
        return vendorName
    }
    func getVendorEmailId()-> String
    {
        if(userDefaults.value(forKey: "vendorEmailId") == nil)
        {
            userDefaults.setValue("", forKey: "vendorEmailId")
        }
        var vendorEmail : String = ""
        vendorEmail = userDefaults.value(forKey: "vendorEmailId") as! String
        
        return vendorEmail
    }
    func getUserEmailId()-> String
    {
        if(userDefaults.value(forKey: "customerEmailId") == nil)
        {
            userDefaults.setValue("", forKey: "customerEmailId")
        }
        var customerEmail : String = ""
        customerEmail = userDefaults.value(forKey: "customerEmailId") as! String
        
        return customerEmail
    }
    func getUserName()-> String
    {
        if(userDefaults.value(forKey: "customername") == nil)
        {
            userDefaults.setValue("", forKey: "customername")
        }
        var customerName : String = ""
        customerName = userDefaults.value(forKey: "customername") as! String
        
        return customerName
    }


    



    
   
    

}
