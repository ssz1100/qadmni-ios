//
//  VendorRegisterViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorRegisterViewController: UIViewController,UITextFieldDelegate {
    
    var producerName : String = ""
    var password : String = ""
    var emailId : String = ""
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        
        let vendorUser = VendorUserRequestModel()
        let vendorData = VendorEmailValidateRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        
        vendorData.emailId = self.emailTxtField.text!
        self.showActivity()
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorEmailValidate(vendorDataRequest: vendorData,
                                          vendorUserRequest: vendorUser,
                                          vendorLangCodeRequest: vendorLangCode,
                                          completionHandler: {
                                            response in
                                            self.hideActivity()
                                            
                                            if(response?.errorCode == 0)
                                            {
                                                
                                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc: VendorShopDetailViewController = storyboard.instantiateViewController(withIdentifier: "VendorShopDetailViewController") as! VendorShopDetailViewController
                                                vc.producerName = self.producerName
                                                vc.emailId = self.emailId
                                                vc.password = self.password
                                                self.present(vc, animated: true, completion: nil)

                                            
                                            }
                                          else{
                                            self.showAlertMessage(title: "Alert", message: "Email Id Exist with another user pleaser try different")
                                            }
                                            
                                            
        })

        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let imageSize = CGSize.init(width: 18, height: 18)
        
        let userloginImage = UIImage(named:"userlogin")
        emailTxtField.addLeftIcon(userloginImage, frame: frame, imageSize: imageSize)
        let passwordImage = UIImage(named:"password")
        passwordTxtField.addLeftIcon(passwordImage, frame: frame, imageSize: imageSize)
        confirmPasswordTxtField.addLeftIcon(passwordImage, frame: frame, imageSize: imageSize)
        let userNameImage = UIImage(named:"username")
        nameTxtField.addLeftIcon(userNameImage, frame: frame, imageSize: imageSize)
        let phoneImage = UIImage(named:"phone")
        phoneTxtField.addLeftIcon(phoneImage, frame: frame, imageSize: imageSize)
        
        producerName = nameTxtField.text!
        password = passwordTxtField.text!
        emailId = emailTxtField.text!
        
    }
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
        
        self.nameTxtField.underlined()
        self.passwordTxtField.underlined()
        self.confirmPasswordTxtField.underlined()
        self.emailTxtField.underlined()
        
        
        self.nextButtonOutlet.roundedButton()
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateData() -> Bool
    {
        
        if (self.nameTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter name")
            return false
        }
        else if (self.passwordTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter password")
            return false
        }
        else if (self.confirmPasswordTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter confirmpassword")
            return false
        }
        else if (self.emailTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter email")
            return false
        }
        else if (self.phoneTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter phonenumber")
            return false
        }
        else if (self.passwordTxtField.text != self.confirmPasswordTxtField.text)
        {
            self.showAlertMessage(title: "Alert", message: "Password unmatched")
            return false
        }
        return true
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField == nameTxtField)
        {
            nameTxtField.resignFirstResponder()
            passwordTxtField.becomeFirstResponder()
        }
        else if (textField == passwordTxtField)
        {
            passwordTxtField.resignFirstResponder()
            confirmPasswordTxtField.becomeFirstResponder()
            
        }
        else if (textField == confirmPasswordTxtField)
        {
           confirmPasswordTxtField.resignFirstResponder()
           emailTxtField.becomeFirstResponder()
        }
        else if (textField == emailTxtField)
        {
            emailTxtField.resignFirstResponder()
            phoneTxtField.becomeFirstResponder()
        }
        else if (textField == phoneTxtField)
        {
           self.view.endEditing(true)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    

   
}
