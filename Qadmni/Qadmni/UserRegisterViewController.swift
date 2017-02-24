//
//  UserRegisterViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class UserRegisterViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var confirmPasswordtxtField: UITextField!

    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    @IBAction func registerUser(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        let customerRegisterData = CustomerRegisterRequestModel()
        let customerRegisterUser = CustomerUserRequestModel()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        customerRegisterData.emailId = self.emailTxtField.text!
        customerRegisterData.name = self.nameTxtField.text!
        customerRegisterData.phone = self.phoneTxtField.text!
        customerRegisterData.password = self.passwordTxtField.text!
        self.showActivity()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerRegister(customerDataRequest: customerRegisterData,
                                           customerUserRequest: customerRegisterUser,
                                           customerLangCodeRequest: customerLangCode,
                                           completionHandler: {
                                            response in
                                            self.hideActivity()
                                            
                                            if(response?.errorCode == 0)
                                            {
                                                
                                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                                
                                                
                                            }
                                            else{
                                                self.showAlertMessage(title: "Alert", message:(response?.message)!)
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
        confirmPasswordtxtField.addLeftIcon(passwordImage, frame: frame, imageSize: imageSize)
        let userNameImage = UIImage(named:"username")
        nameTxtField.addLeftIcon(userNameImage, frame: frame, imageSize: imageSize)
        let phoneImage = UIImage(named:"phone")
        phoneTxtField.addLeftIcon(phoneImage, frame: frame, imageSize: imageSize)

    }
    
    override func viewDidLayoutSubviews() {
       self.subView.roundedView()
        
        self.nameTxtField.underlined()
        self.passwordTxtField.underlined()
        self.confirmPasswordtxtField.underlined()
        self.emailTxtField.underlined()
        
        
        self.registerButtonOutlet.roundedButton()
        
        
        
        
        
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
        else if (self.confirmPasswordtxtField.text?.isEmpty)!
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
        else if (self.passwordTxtField.text != self.confirmPasswordtxtField.text)
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
            confirmPasswordtxtField.becomeFirstResponder()
            
        }
        else if (textField == confirmPasswordtxtField)
        {
            confirmPasswordtxtField.resignFirstResponder()
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
