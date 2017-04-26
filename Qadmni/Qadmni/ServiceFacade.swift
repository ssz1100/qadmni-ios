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
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
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
        print(vendorLoginParameter)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorLoginParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var vendorLoginResponseModel : VendorLoginResponseModel = VendorLoginResponseModel()
                guard response.result.isSuccess else{
                    vendorLoginResponseModel.errorCode = -1
                    completionHandler(vendorLoginResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        vendorLoginResponseModel.errorCode = -1
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
    
    public func VendorEmailValidate(vendorDataRequest:VendorEmailValidateRequestModel?,
                                    vendorUserRequest:VendorUserRequestModel?,
                                    vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                                    completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "isduplicateemail")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorEmailValidateParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)

        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorEmailValidateParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let baseresponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    baseresponseModel.errorCode = -1
                    completionHandler(baseresponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        baseresponseModel.errorCode = -1
                        completionHandler(baseresponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseresponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseresponseModel.message = responseErrorMessage
                

                completionHandler(baseresponseModel)
                
        }

    
    }
    
    public func VendorRegister(vendorDataRequest:VendorSignupRequestModel?,
                               vendorUserRequest:VendorUserRequestModel?,
                               vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                               completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "vendorsignup")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorRegisterParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorRegisterParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let baseresponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    baseresponseModel.errorCode = -1
                    completionHandler(baseresponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        baseresponseModel.errorCode = -1
                        completionHandler(baseresponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseresponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseresponseModel.message = responseErrorMessage
                
                
                
                completionHandler(baseresponseModel)
                
        }
    
    }
    
    public func VendorItems(vendorDataRequest:VendorItemRequestmodel?,
                            vendorUserRequest:VendorUserRequestModel?,
                            vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                            completionHandler: @escaping ([VendorItemResponseModel?])->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "vendoritems")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorItemParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorItemParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let vendorItemResponseModel = VendorItemResponseModel()
                guard response.result.isSuccess else{
                    //completionHandler(vendorItemResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        //completionHandler(vendorItemResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                vendorItemResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                vendorItemResponseModel.message = responseErrorMessage
                
                var dict: Array<VendorItemResponseModel> = []
                if(responseErrorCode == 0)
                {
                    let responseData : String = (responseValue["data"] as? String)!
                    dict=[VendorItemResponseModel](json:responseData)
                    
                }

                
                completionHandler(dict)
                
        }
    
    }
    
    public func VendorCategory(vendorDataRequest:VendorCategoryRequestModel?,
                            vendorUserRequest:VendorUserRequestModel?,
                            vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                            completionHandler: @escaping ([VendorCategoryResponseModel?])->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "categorylist")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorCategoryParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorCategoryParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let vendorCategoryResponseModel = VendorCategoryResponseModel()
                guard response.result.isSuccess else{
                    //completionHandler(vendorItemResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        //completionHandler(vendorItemResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                vendorCategoryResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                vendorCategoryResponseModel.message = responseErrorMessage
                
                var dict: Array<VendorCategoryResponseModel> = []
                if(responseErrorCode == 0)
                {
                    let responseData : String = (responseValue["data"] as? String)!
                    dict=[VendorCategoryResponseModel](json:responseData)
                    
                }
                
                
                completionHandler(dict)
                
        }
        
    }
    
    public func VendorAddProduct(vendorDataRequest:AddProductRequestModel?,
                               vendorUserRequest:VendorUserRequestModel?,
                               vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                               completionHandler: @escaping (AddProductResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "addproduct")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let addProductParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: addProductParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var addProductResponseModel = AddProductResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(addProductResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(addProductResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                addProductResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                addProductResponseModel.message = responseErrorMessage
                
                if(responseErrorCode == 0){
                    let responseRegistrationData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseRegistrationData);
                    
                    addProductResponseModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: addProductResponseModel)
                    addProductResponseModel = AddProductResponseModel(json : responseRegistrationData)
                    
                }
                completionHandler(addProductResponseModel)
                
        }
        
    }
    
    public func VendorForgotPassword(vendorDataRequest:VendorForgotPasswordRequestModel?,
                                    vendorUserRequest:VendorUserRequestModel?,
                                    vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                                       completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "vendorforgotpassword")!
        let vendorForgotPasswordDataString : String? = vendorDataRequest?.toJsonString()
        let vendorForgotPasswordUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorForgotPasswordParameter: Parameters = buildRequestParameters(dataString: vendorForgotPasswordDataString, userString: vendorForgotPasswordUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorForgotPasswordParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let baseResponseModel : BaseResponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(baseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(baseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseResponseModel.message = responseErrorMessage
                
                completionHandler(baseResponseModel)
                
        }
    }
    
    public func VendorOrder(vendorDataRequest:VendorOrderReqModel?,
                               vendorUserRequest:VendorUserRequestModel?,
                               vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                               completionHandler: @escaping ([VendorOrderResponseModel?])->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "vendororders")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorOrderParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorOrderParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let vendorOrderResponseModel = VendorOrderResponseModel()
                guard response.result.isSuccess else{
                    //completionHandler(vendorItemResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        //completionHandler(vendorItemResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                vendorOrderResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                vendorOrderResponseModel.message = responseErrorMessage
                
                var dict: Array<VendorOrderResponseModel> = []
                if(responseErrorCode == 0)
                {
                    let responseData : String = (responseValue["data"] as? String)!
                    dict=[VendorOrderResponseModel](json:responseData)
                    
                }
                
                
                completionHandler(dict)
                
        }
        
    }
    
    public func UpdateDeliveryStatus(vendorDataRequest:UpdateDelStatusViewController?,
                            vendorUserRequest:VendorUserRequestModel?,
                            vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                            completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "updatedeliverystatus")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let updateDeliveryStatusParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: updateDeliveryStatusParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let baseResponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(baseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(baseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseResponseModel.message = responseErrorMessage
                
                completionHandler(baseResponseModel)
                
        }
        
    }



    
    public func AddproductMultiPathData(fileData :Data,addProductImage : AddProductImageRequestModel?)
    {
      let endPointUrl : URL = URL(string:baseUrl + "addproductimage")!
        
//        var params: Parameters = Parameters()
//    params["json"] = addProductImage as AnyObject?
//      let data: Data = addProductImage as AnyObject? as! Data
        let addProductImageString : String? = addProductImage?.toJsonString()
       
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(fileData,
                                     withName: "photo",
                                     fileName: "abc.jpeg",
                                     mimeType: "image/jpeg")
            multipartFormData.append((addProductImageString?.data(using: String.Encoding.utf8))!, withName: "json")
//            for (key, value) in params {
//                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            }
        }, to:endPointUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
    


    }
    
    
    public func vendorItemDetail(vendorDataRequest:VendorItemDetailReqModel?,
                                 vendorUserRequest:VendorUserRequestModel?,
                                 vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                                 completionHandler: @escaping (VendorItemDetailResModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "itemdetails")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorItemDetailParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorItemDetailParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var vendorItemDetailResModel = VendorItemDetailResModel()
                guard response.result.isSuccess else{
                    completionHandler(vendorItemDetailResModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(vendorItemDetailResModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                vendorItemDetailResModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                vendorItemDetailResModel.message = responseErrorMessage
                
                if(responseErrorCode == 0){
                    let responseData : String? = responseValue["data"] as? String
                    
                    let dict : NSDictionary = EVReflection.dictionaryFromJson(responseData);
                    
                    vendorItemDetailResModel = EVReflection.setPropertiesfromDictionary(dict, anyObject: vendorItemDetailResModel)
                    vendorItemDetailResModel = VendorItemDetailResModel(json : responseData)
                    
                }
                completionHandler(vendorItemDetailResModel)
                
        }
        
    }
    
    public func vendorUpdateProduct(vendorDataRequest:VendorUpdateProductReqModel?,
                                 vendorUserRequest:VendorUserRequestModel?,
                                 vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                                 completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "updateproduct")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let vendorUpdateProductParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: vendorUpdateProductParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                var baseResponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(baseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(baseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseResponseModel.message = responseErrorMessage
                completionHandler(baseResponseModel)
                
        }
        
    }
    
    public func updateVendorProfile(vendorDataRequest:UpdateVendorProfileReqModel?,
                                     vendorUserRequest:VendorUserRequestModel?,
                                     vendorLangCodeRequest:VendorLangCodeRequestmodel?,
                                     completionHandler: @escaping (BaseResponseModel?)->Void)
    {
        let endPointUrl : URL = URL(string:baseUrl + "updateproducerprofile")!
        let vendorDataString : String? = vendorDataRequest?.toJsonString()
        let vendorUserString : String? = vendorUserRequest?.toJsonString()
        let vendorLangCodeString : String? = vendorLangCodeRequest?.toJsonString()
        
        let updateVendorProfileParameter: Parameters = buildRequestParameters(dataString: vendorDataString, userString: vendorUserString, langCodeString: vendorLangCodeString)
        
        
        Alamofire.request(endPointUrl,
                          method: .post,
                          parameters: updateVendorProfileParameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON{
                response in
                let baseResponseModel = BaseResponseModel()
                guard response.result.isSuccess else{
                    completionHandler(baseResponseModel)
                    return
                }
                guard  let responseValue = response.result.value as? [String : AnyObject]
                    else{
                        completionHandler(baseResponseModel)
                        return
                        
                }
                
                let responseErrorCode : Int32 = responseValue["errorCode"] as! Int32
                baseResponseModel.errorCode = responseErrorCode
                let responseErrorMessage : String = (responseValue["message"] as? String)!
                baseResponseModel.message = responseErrorMessage
                
                completionHandler(baseResponseModel)
                
        }
        
    }

        
    
    private func buildRequestParameters(dataString:String?, userString: String?, langCodeString : String?) -> Parameters{
        var params: Parameters = Parameters()
        
        params["data"] = dataString as AnyObject?
        params["user"] = userString as AnyObject?
        params["langCode"] = self.userDefaultManager.getLanguageCode()
        return params
    }
    


    
    




}
