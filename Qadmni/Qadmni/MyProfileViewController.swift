//
//  MyProfileViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 31/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController,UITextFieldDelegate {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var myProfile = UserProfileDetail()
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var nameTxtField: UITextField!

    @IBOutlet var emailtxtField: UITextField!
    
    @IBOutlet var passwordTxtField: UITextField!
    
    @IBOutlet var addressTxtField: UITextField!
    
    
    @IBAction func saveProfileButton(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        let updateCustProfileReqModel = UpdateCustProfileReqModel()
        updateCustProfileReqModel.name = nameTxtField.text!
        updateCustProfileReqModel.password = passwordTxtField.text!
        updateCustProfileReqModel.emailId = emailtxtField.text!
        updateCustProfileReqModel.phone = addressTxtField.text!
        
        let customerUpdateProfileUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        self.showActivity()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerUpdateProfile(customerDataRequest: updateCustProfileReqModel,
                                                customerUserRequest: customerUpdateProfileUser, customerLangCodeRequest: customerLangCode,
                                                completionHandler: {
                                                    response in
                                                    self.hideActivity()
                                                    if(response?.errorCode == 0)
                                                    {
                                                    self.showAlertMessage(title: NSLocalizedString("success.title", comment: ""), message: NSLocalizedString("profile.message", comment: ""))
                                                        let updatedProfile = UserProfileDetail()
                                                        updatedProfile.password = self.passwordTxtField.text!
                                                        updatedProfile.phoneNumber = self.addressTxtField.text!
                                                        updatedProfile.name = self.nameTxtField.text!
                                                        self.userDefaultManager.saveUpdatedCustomerDetails(updateProfile:updatedProfile)
                                                    }else{
                                                        self.showAlertMessage(title:NSLocalizedString("serverError", comment: "") , message: (response?.message)!)
                                                    }
                                                    
        })

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myProfile = userDefaultManager.getUserProfiledetail()
        self.nameTxtField.text = myProfile.name
        self.emailtxtField.text = myProfile.email
        self.passwordTxtField.text = myProfile.password
        self.addressTxtField.text = myProfile.phoneNumber
        
        self.emailtxtField.isUserInteractionEnabled = false
        
        
        
        }
    
    override func viewDidLayoutSubviews()
    {
        profileImage.roundedImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func validateData() -> Bool
    {
        
        if (self.passwordTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("profile.password", comment: ""))
            return false
        }
        else if (self.addressTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("profile.phoneNumber", comment: ""))
            return false
        }
        else if (self.nameTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("profile.username", comment: ""))
            return false
        }

        
               return true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charsLimit = 10
        
        let startingLength = addressTxtField.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
    }


    

   
}
