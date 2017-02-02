//
//  ServiceFacade.swift
//  Qadmni
//
//  Created by Prakash Sabale on 01/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

public class ServiceFacade
{
    var baseUrl : String
    
    init( configUrl : String?)
    {
        baseUrl = configUrl!
    }
    
    
//    public func requestToServer(endUrl:String,baseRequestParameter: BaseRequestModel?,requestToken: Int,completionHandler:@escaping (BaseResponseModel?) -> Void )
//    {
//        let endPointUrl : URL = URL(string:baseUrl + endUrl)!
//        let data : String? = baseRequestParameter?.data
//        let user : String? = baseRequestParameter?.user
//        let langCode: String? = baseRequestParameter?.langCode
//        
//        let requestRegisterParameter : Parameters = buildRequestParameters(
//            dataString: data, userString: user,langCodeString:langCode)
//        
//        Alamofire.request(endPointUrl,
//                          method: .post,
//                          parameters: requestRegisterParameter,
//                          encoding: JSONEncoding.default,
//                          headers: nil)
//            .responseJSON{
//                response in
//                var baseResponseModel: BaseResponseModel? = BaseResponseModel()
//                guard response.result.isSuccess else{
//                    completionHandler(baseResponseModel)
//                    return
//                }
//                guard  let responseValue = response.result.value as? [String : AnyObject]
//                    else{
//                        completionHandler(baseResponseModel)
//                        return
//                        
//                }
//                
////                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
////                employeeLoginReponseModel?.errorCode = responseErrorCode
////                //print(responseErrorCode)
////                let responseErrorMessage : String = (responseValue["message"] as? String)!
////                employeeLoginReponseModel?.message = responseErrorMessage
////                //print(responseErrorMessage)
////                
////                if(responseErrorCode == 0){
////                    let responseRegistrationData : String? = responseValue["data"] as? String
//                
//                    let dict : NSDictionary = EVReflection.dictionaryFromJson(response.result.value as? String)
//                    baseResponseModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: baseResponseModel!)
//                    baseResponseModel? = BaseResponseModel(json : baseResponseModel)
//                    
//                }
//                completionHandler(baseResponseModel?)
//        }
//
//
//    
    
    public func vendorLogin(vendorDataRequest:LoginVendorRequestModel?,
                            vendorUserRequest:VendorUserRequestModel?,
                            vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                            completionHandler: @escaping (VendorLoginResponseModel?)->Void )
    {
        let endPointUrl : URL = URL(string:baseUrl + "vendorlogin")!
        let vendorLoginDataString : String? = vendorDataRequest?.toJsonString()
        let vendorLoginUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorLoginParameter: Parameters = buildRequestParameters(dataString: vendorLoginDataString, userString: vendorLoginUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorLoginParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var vendorLoginResponseModel : VendorLoginResponseModel = VendorLoginResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(vendorLoginResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(vendorLoginResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                vendorLoginResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                vendorLoginResponseModel.message = responseErrorMessage
                
                if(responseErrorCode == 0){
                    let responseRegistrationData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseRegistrationData);
                    
                    vendorLoginResponseModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: vendorLoginResponseModel)
                    vendorLoginResponseModel = VendorLoginResponseModel(json : responseRegistrationData)
                    
                }
                completionHandler(vendorLoginResponseModel)
                
                }
            }
    
    
    
    
//    private func buildRequestParameters(dataString:String?, userString: String?,langCodeString : String?) -> Parameters{
//        var params: Parameters = Parameters()
//        
//        params["data"] = dataString as AnyObject?
//        params["user"] = userString as AnyObject?
//         params["langCode"] = langCodeString as AnyObject?
//        return params
//    }
    
    
    private func buildRequestParameters(dataString:String?, userString: String?, langCodeString : String?) -> Parameters{
        var params: Parameters = Parameters()
        
        params["data"] = dataString as AnyObject?
        params["user"] = userString as AnyObject?
        params["langCode"] = userString as AnyObject?
        return params
    }
    


    
    




}
