//
//  VendorForgotPasswordViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 14/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorForgotPasswordViewController: UIViewController {
    @IBOutlet var subView: UIView!
    
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var buttonOutlet: UIButton!
    
    @IBAction func PasswordchangeButtonTapped(_ sender: UIButton) {
        
        let vendorForgotPasswordData  = VendorForgotPasswordRequestModel()
        let vendorForgotPasswordUser = VendorUserRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        vendorForgotPasswordData.emailId = self.emailTxtField.text!
        
        
        self.showActivity()
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorForgotPassword(vendorDataRequest: vendorForgotPasswordData,
                                           vendorUserRequest: vendorForgotPasswordUser,
                                           vendorLangCodeRequest: vendorLangCode,
                                           completionHandler: {
                                            response in
                                            self.hideActivity()
                                            
                                            if(response?.errorCode == 0)
                                            {
                                                
                                                
                                                let alertView = UIAlertController.init(title:NSLocalizedString("success.title", comment: ""), message: NSLocalizedString("forgotPassword.message", comment: ""), preferredStyle: .alert)
                                                let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                    
                                                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VendorLoginViewController") as UIViewController
                                                    self.present(vc, animated: true, completion: nil)
                                                    
                                                }
                                                let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
                                                alertView.addAction(defaultAction)
                                                alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                                self.present(alertView, animated: true)
                                                
                                            }
                                            else{
                                                self.showAlertMessage(title:NSLocalizedString("serverError", comment: ""), message:(response?.message)!)
                                            }

        
        })
        
    }
    @IBAction func backBarButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VendorLoginViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
        
        self.buttonOutlet.roundedButton()
        
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
