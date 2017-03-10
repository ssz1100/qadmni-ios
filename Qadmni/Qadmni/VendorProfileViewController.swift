//
//  VendorProfileViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 10/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorProfileViewController: UIViewController {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var vendorProfile = VendorProfileDetail()
   
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var nameTxtField: UITextField!
    
    @IBOutlet var emailtxtField: UITextField!
    
    @IBOutlet var passwordTxtField: UITextField!

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        let updateVendorProfileUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let updateVendorProfileData = UpdateVendorProfileReqModel()
        updateVendorProfileData.name = nameTxtField.text!
        updateVendorProfileData.emailId = emailtxtField.text!
        updateVendorProfileData.password = passwordTxtField.text!
        let vendorLangCode = VendorLangCodeRequestmodel()
        self.showActivity()
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.updateVendorProfile(vendorDataRequest: updateVendorProfileData,
                                          vendorUserRequest: updateVendorProfileUser,
                                          vendorLangCodeRequest: vendorLangCode,
                                          completionHandler: {
                                                response in
                                            self.hideActivity()
                                            if(response?.errorCode == 0)
                                            {
                                                self.showAlertMessage(title: "Profile Update", message: "Profile updated successfully")
                                                let updatedVendorprofile = VendorProfileDetail()
                                                updatedVendorprofile.name = self.nameTxtField.text!
                                                updatedVendorprofile.password = self.passwordTxtField.text!
                                                self.userDefaultManager.saveUpdatedVendorDetails(updateVendorProfile: updatedVendorprofile)
                                            }else{
                                                self.showAlertMessage(title: "Profile update Failed", message: (response?.message)!)
                                            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vendorProfile = userDefaultManager.getVendorProfiledetail()
        self.nameTxtField.text = vendorProfile.name
        self.emailtxtField.text = vendorProfile.email
        self.passwordTxtField.text = vendorProfile.password
        self.emailtxtField.isUserInteractionEnabled = false
    }
    override func viewDidLayoutSubviews()
    {
        profileImage.roundedImageView() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func validateData() -> Bool
    {
        
        if (self.passwordTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter password")
            return false
        }
        else if (self.nameTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter name")
            return false
        }
        return true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    

}