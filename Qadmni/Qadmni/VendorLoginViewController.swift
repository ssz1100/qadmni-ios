//
//  VendorLoginViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 19/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import Alamofire
import EVReflection

class VendorLoginViewController: UIViewController {
    
    let vendorLoginResponseModel:VendorLoginResponseModel = VendorLoginResponseModel()
    
    @IBOutlet weak var userNameTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!

    @IBOutlet weak var loginVendorButton: UIButton!
    
    
    @IBOutlet weak var subView: UIView!
    
    @IBAction func loginVendorButtonTapped(_ sender: UIButton)
    {
//        var baseRequestModel : BaseRequestModel = BaseRequestModel()
//        var vendorLoginRequestModel : LoginVendorRequestModel = LoginVendorRequestModel()
//        vendorLoginRequestModel.emailId = userNameTxtField.text!
//        vendorLoginRequestModel.password = passwordTxtField.text!
//        vendorLoginRequestModel.pushNotificationId = "xfdxffev"
//
//        
//        baseRequestModel.user = ""
//        baseRequestModel.data = vendorLoginRequestModel.toJsonString()
//        baseRequestModel.langCode=""
//        
//     let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
//        serviceFacade.requestToServer(endUrl:"vendorlogin",baseRequestParameter: baseRequestModel,requestToken: 1,completionHandler : {
//            response in
//        
//        })
        
         print(NSHomeDirectory())
        
        let delagate = UIApplication.shared.delegate as! AppDelegate
        let pathForPlistFile = delagate.plistPathInDocuments
        
        
        let vendorLoginUser = VendorUserRequestModel()
        let vendorLoginData = LoginVendorRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        vendorLoginData.emailId = userNameTxtField.text!
        vendorLoginData.password = passwordTxtField.text!
        
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.vendorLogin(vendorDataRequest: vendorLoginData,
                                  vendorUserRequest: vendorLoginUser,
                                  vendorLangCodeRequest: vendorLangCode,
                                  completionHandler: {
                                    response in
                                    debugPrint(response)
//                                    let producerId = "producerId"
//                                    let producerName = "producerName"
//                                    let businessNameEn = "businessNameEn"
//                                    let businessNameAr = "businessNameAr"
//                                    let businessAddress = "businessAddress"
//                                    let businessLat = "businessLat"
//                                    let businessLong = "businessLong"
                                    
                    PlistManager.sharedInstance.saveValue(value: response?.producerId as AnyObject, forKey: "producerId")
                    PlistManager.sharedInstance.saveValue(value: response?.producerName as AnyObject, forKey: "producerName")
                    PlistManager.sharedInstance.saveValue(value: response?.businessNameEn as AnyObject, forKey: "businessNameEn")
                    PlistManager.sharedInstance.saveValue(value: response?.businessNameAr as AnyObject, forKey: "businessNameAr")
                    PlistManager.sharedInstance.saveValue(value: response?.businessAddress as AnyObject, forKey: "businessAddress")
                    PlistManager.sharedInstance.saveValue(value: response?.businessLat as AnyObject, forKey: "businessLat")
                    PlistManager.sharedInstance.saveValue(value: response?.businessLong as AnyObject, forKey: "businessLong")
                                    
        
        })
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        let frame = CGRect.init(x: 0, y: 0, width: 40, height:40)
        let imageSize = CGSize.init(width: 30, height: 30)
        
        let userloginImage = UIImage(named:"userlogin")
        userNameTxtField.addLeftIcon(userloginImage, frame: frame, imageSize: imageSize)
        let passwordImage = UIImage(named:"password")    
        passwordTxtField.addLeftIcon(passwordImage, frame: frame, imageSize: imageSize)

    }
    
    override func viewDidLayoutSubviews() {
       self.subView.roundedView()        
        self.userNameTxtField.underlined()
        
        self.loginVendorButton.roundedButton()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
