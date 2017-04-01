//
//  ForgotPasswordViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 21/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
   
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var forgotPasswordButtonOutlet: UIButton!
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        
        let customerForgotPasswordData  = CustomerForgotPasswordRequestModel()
        let customerForgotPasswordUser = CustomerUserRequestModel()
        let customerLangCode = CustomerLangCodeRequestModel()
        customerForgotPasswordData.emailId = self.emailTxtField.text!
        
        
        self.showActivity()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerForgotPassword(customerDataRequest: customerForgotPasswordData,
                                                 customerUserRequest: customerForgotPasswordUser,
                                                 customerLangCodeRequest: customerLangCode,
                                                 completionHandler: {
                                                    response in
                                                    self.hideActivity()
                                                    
                                                    if(response?.errorCode == 0)
                                                    {
                                                       
                                                        
                                                let alertView = UIAlertController.init(title:NSLocalizedString("success.title", comment: ""), message: NSLocalizedString("forgotPassword.message", comment: ""), preferredStyle: .alert)
                                                let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                            
                                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                                            
                                                }
                                                let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
                                                alertView.addAction(defaultAction)
                                                alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                                self.present(alertView, animated: true)
    
                                                }
                                                else{
                                                        self.showAlertMessage(title: NSLocalizedString("serverError", comment: ""), message:(response?.message)!)
                                                    }

        
        })
        
        
        
    }

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        
       
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
       
        self.forgotPasswordButtonOutlet.roundedButton()
      
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
