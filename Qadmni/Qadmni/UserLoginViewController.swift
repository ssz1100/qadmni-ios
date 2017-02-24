//
//  UserLoginViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 18/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController,UITextFieldDelegate {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    
    @IBOutlet weak var userNameTxtField: UITextField!

    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }

        
        let customerLoginData = CustomerLoginRequestModel()
        let customerLoginUser = CustomerUserRequestModel()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        customerLoginData.emailId = self.userNameTxtField.text!
        customerLoginData.password = self.passwordTxtField.text!
        
        self.showActivity()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerLogin(customerDataRequest: customerLoginData,
                                        customerUserRequest: customerLoginUser,
                                        customerLangCodeRequest: customerLangCode,
                                        completionHandler: {
                                            response in
                                            self.hideActivity()
                                            if(response?.errorCode == 0)
                                            {
                                                response?.emailId = self.userNameTxtField.text!
                                                response?.password = self.passwordTxtField.text!
                                               self.userDefaultManager.saveCustomerData(customerResponse: response)
                                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                                
                                                
                                                
                                            }
                                            else
                                            {
                                                self.showAlertMessage(title: "Authenication Error", message: (response?.message)!)
                                                self.userNameTxtField.text! = ""
                                                self.passwordTxtField.text! = ""
                                            }

                                            
        
        })
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let imageSize = CGSize.init(width: 25, height: 25)
        
        let userloginImage = UIImage(named:"userlogin")
        userNameTxtField.addLeftIcon(userloginImage, frame: frame, imageSize: imageSize)
        let passwordImage = UIImage(named:"password")
        passwordTxtField.addLeftIcon(passwordImage, frame: frame, imageSize: imageSize)

        
    }
    
    override func viewDidLayoutSubviews() {

        self.subView.roundedView()
        
        
        self.userNameTxtField.underlined()
        
        self.loginButtonOutlet.roundedButton()
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateData() -> Bool
    {
        
        if (self.userNameTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please Enter User Name")
            return false
        }
        else if (self.passwordTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please Enter Password")
            return false
        }
        return true
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField == userNameTxtField)
        {
            userNameTxtField.resignFirstResponder()
            passwordTxtField.becomeFirstResponder()
        }
        else if (textField == passwordTxtField)
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
