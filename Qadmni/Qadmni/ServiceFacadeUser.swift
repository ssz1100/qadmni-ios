 //
//  ServiceFacadeUser.swift
//  Qadmni
//
//  Created by Prakash Sabale on 14/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

public class ServiceFacadeUser
{
    var baseUrl : String
    
    init( configUrl : String?)
    {
        baseUrl = configUrl!
    }
    
    public func CustomerLogin(customerDataRequest:CustomerLoginRequestModel?,
                              customerUserRequest:CustomerUserRequestModel?,
                              customerLangCodeRequest:CustomerLangCodeRequestModel?,
                              completionHandler: @escaping (CustomerLoginResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "customerlogin")!
        let customerLoginDataString : String? = customerDataRequest?.toJsonString()
        let customerLoginUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerLoginParameter: Parameters = buildRequestParameters(dataString: customerLoginDataString, userString: customerLoginUserString, langCodeString: customerLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerLoginParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var customerLoginResponseModel : CustomerLoginResponseModel = CustomerLoginResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(customerLoginResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(customerLoginResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                customerLoginResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                customerLoginResponseModel.message = responseErrorMessage
                
                if(responseErrorCode == 0){
                    let responseLoginData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseLoginData);
                    
                    customerLoginResponseModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: customerLoginResponseModel)
                    customerLoginResponseModel = CustomerLoginResponseModel(json : responseLoginData)
                    
                }
                completionHandler(customerLoginResponseModel)
                
        }
    }
    
    public func CustomerRegister(customerDataRequest:CustomerRegisterRequestModel?,
                              customerUserRequest:CustomerUserRequestModel?,
                              customerLangCodeRequest:CustomerLangCodeRequestModel?,
                              completionHandler: @escaping (CustomerRegisterResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "registercustomer")!
        let customerRegisterDataString : String? = customerDataRequest?.toJsonString()
        let customerRegisterUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerRegisterParameter: Parameters = buildRequestParameters(dataString: customerRegisterDataString, userString: customerRegisterUserString, langCodeString: customerLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerRegisterParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var customerRegisterResponseModel : CustomerRegisterResponseModel = CustomerRegisterResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(customerRegisterResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(customerRegisterResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                customerRegisterResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                customerRegisterResponseModel.message = responseErrorMessage
                
                if(responseErrorCode == 0){
                    let responseRegisterData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseRegisterData);
                    
                    customerRegisterResponseModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: customerRegisterResponseModel)
                    customerRegisterResponseModel = CustomerRegisterResponseModel(json : responseRegisterData)
                    
                }
                completionHandler(customerRegisterResponseModel)
                
        }
    }

    public func CustomerForgotPassword(customerDataRequest:CustomerForgotPasswordRequestModel?,
                                 customerUserRequest:CustomerUserRequestModel?,
                                 customerLangCodeRequest:CustomerLangCodeRequestModel?,
                                 completionHandler: @escaping (CustomerBaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "customerforgotpassword")!
        let customerForgotPasswordDataString : String? = customerDataRequest?.toJsonString()
        let customerForgotPasswordUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerForgotPasswordParameter: Parameters = buildRequestParameters(dataString: customerForgotPasswordDataString, userString: customerForgotPasswordUserString, langCodeString: customerLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerForgotPasswordParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let customerBaseResponseModel : CustomerBaseResponseModel = CustomerBaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(customerBaseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(customerBaseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                customerBaseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                customerBaseResponseModel.message = responseErrorMessage
                
                completionHandler(customerBaseResponseModel)
                
        }
    }

    public func CustomerPlaceOrder(customerDataRequest:CustDetailsPlaceOrderReqModel?,
                                       customerUserRequest:CustomerUserRequestModel?,
                                       customerLangCodeRequest:CustomerLangCodeRequestModel?,
                                       completionHandler: @escaping (CustPlaceOrderResModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "initiateorder")!
        let customerPlaceOrderDataString : String? = customerDataRequest?.toJsonString()
        let customerPlaceOrderUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerPlaceOrderParameter: Parameters = buildRequestParameters(dataString: customerPlaceOrderDataString, userString: customerPlaceOrderUserString, langCodeString: customerLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerPlaceOrderParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var custPlaceOrderResModel : CustPlaceOrderResModel = CustPlaceOrderResModel()
                guard response.result.isSuccess else{
                    completionHandler(custPlaceOrderResModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(custPlaceOrderResModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                custPlaceOrderResModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                custPlaceOrderResModel.message = responseErrorMessage
                if(responseErrorCode == 0){
                    let responsePlaceOrderData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responsePlaceOrderData);
                    
                    custPlaceOrderResModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: custPlaceOrderResModel)
                    custPlaceOrderResModel = CustPlaceOrderResModel(json : responsePlaceOrderData)
                    
                }
                completionHandler(custPlaceOrderResModel)
                
        }
    }
    
    
    public func CustomerProcessOrder(customerDataRequest:CustProcessOrderReqModel?,
                                   customerUserRequest:CustomerUserRequestModel?,
                                   customerLangCodeRequest:CustomerLangCodeRequestModel?,
                                   completionHandler: @escaping (CustProcessOrderResModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "processorder")!
        let customerProcessOrderDataString : String? = customerDataRequest?.toJsonString()
        let customerProcessOrderUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerProcessOrderParameter: Parameters = buildRequestParameters(dataString: customerProcessOrderDataString, userString: customerProcessOrderUserString, langCodeString: customerLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerProcessOrderParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var custProcessOrderResModel : CustProcessOrderResModel = CustProcessOrderResModel()
                guard response.result.isSuccess else{
                    completionHandler(custProcessOrderResModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(custProcessOrderResModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                custProcessOrderResModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                custProcessOrderResModel.message = responseErrorMessage
                if(responseErrorCode == 0){
                    let responseProcessOrderData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseProcessOrderData);
                    
                    custProcessOrderResModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: custProcessOrderResModel)
                    custProcessOrderResModel = CustProcessOrderResModel(json : responseProcessOrderData)
                    
                }
                completionHandler(custProcessOrderResModel)
                
        }
    }

    
    public func CustomerConfirmOrder(customerDataRequest:CustConfirmOrderReqModel?,
                                     customerUserRequest:CustomerUserRequestModel?,
                                     customerLangCodeRequest:CustomerLangCodeRequestModel?,
                                     completionHandler: @escaping (CustomerBaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "confirmorder")!
        let customerConfirmOrderDataString : String? = customerDataRequest?.toJsonString()
        let customerConfirmOrderUserString : String? = customerUserRequest?.toJsonString()
        let customerLangCodeString : String? = customerLangCodeRequest?.toJsonString()
        
        let customerConfirmOrderParameter: Parameters = buildRequestParameters(dataString: customerConfirmOrderDataString, userString: customerConfirmOrderUserString, langCodeString: customerLangCodeString)
        print(customerConfirmOrderParameter)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: customerConfirmOrderParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let customerBaseResponseModel : CustomerBaseResponseModel = CustomerBaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(customerBaseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(customerBaseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                customerBaseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                customerBaseResponseModel.message = responseErrorMessage
                
                completionHandler(customerBaseResponseModel)
                
        }
    }
    
    public func CustomerCategory(customerDataRequest:CustcategoryListReqModel?,
                               customerUserRequest:CustomerUserRequestModel?,
                               customerLangCodeRequest:CustomerLangCodeRequestModel?,
                               completionHandler: @escaping ([CustCategoryListResModel?])->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "categorylist")!
        let customerDataString : String? = ""
        let customerUserString : String? = ""
        let customerLangCodeString : String? = ""
        
        let custCategoryParameter: Parameters = buildRequestParameters(dataString: customerDataString, userString: customerUserString, langCodeString: customerLangCodeString)
        //let dispatchQueue = DispatchQueue(label: "Main", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        let alamoFireRequest:DataRequest = Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil);
        
            alamoFireRequest.responseJSON (queue: DispatchQueue.main, completionHandler: {
                response in
                let custCategoryListResModel = CustCategoryListResModel()
                guard response.result.isSuccess else{
                    //completionHandler(nil)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                      //  completionHandler(nil)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                custCategoryListResModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                custCategoryListResModel.message = responseErrorMessage
                
                var dict: Array<CustCategoryListResModel> = []
                if(responseErrorCode == 0)
                {
                    let responseData : String = (responseValue["data"] as? String)!
                    dict=[CustCategoryListResModel](json:responseData)
                    
                }
                completionHandler(dict)
                
        })
        
    }
    


    
    
    
    

    private func buildRequestParameters(dataString:String?, userString: String?, langCodeString : String?) -> Parameters{
        var params: Parameters = Parameters()
        
        params["data"] = dataString as AnyObject?
        params["user"] = userString as AnyObject?
        params["langCode"] = langCodeString as AnyObject?
        return params
    }


}
