//
//  VendorShopDetailViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorShopDetailViewController: UIViewController,GoogleMapDelegate,UITextFieldDelegate {
    
    var businessLattitude : Double = 0.0
    var businessLongitude : Double = 0.0
    
    var producerName : String=""
    var emailId : String = ""
    var password : String = ""
    
    @IBOutlet weak var shopDetailLabel: UILabel!
    @IBOutlet var businessNameArabicTxtField: UITextField!
    
    @IBOutlet weak var businessNameTxtField: UITextField!
    
    @IBOutlet var businessLocationLabel: UILabel!
    
    @IBOutlet var businessLocationView: UIView!
    
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shopRegisterButton(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
               
        let vendorUser = VendorUserRequestModel()
        let vendorRegisterData = VendorSignupRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        let vendorRegisterViewController = VendorRegisterViewController()
        
        vendorRegisterData.businessNameEn = businessNameTxtField.text!
        vendorRegisterData.businessNameAr = businessNameArabicTxtField.text!
        vendorRegisterData.businessAddress = businessLocationLabel.text!
        vendorRegisterData.producerName = producerName
        vendorRegisterData.emailId  = emailId
        vendorRegisterData.password = password
        if (businessLattitude == 0.0 || businessLongitude == 0.0)
        {
            return
        }
        vendorRegisterData.businessLat = businessLattitude
        vendorRegisterData.businessLong = businessLongitude
        
        self.showActivity()
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorRegister(vendorDataRequest: vendorRegisterData,
                                     vendorUserRequest: vendorUser,
                                     vendorLangCodeRequest: vendorLangCode,
                                     completionHandler: {
                                        response in
                                        self.hideActivity()
                                   
                                        if(response?.errorCode == 0)
                                        {
                                            let alertView = UIAlertController.init(title:NSLocalizedString("registrationSuccess.title", comment: ""), message: NSLocalizedString("registrationSuccess.message", comment: ""), preferredStyle: .alert)
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
                                        else
                                        {
                                            self.showAlertMessage(title: NSLocalizedString("serverError", comment: ""), message: (response?.message)!)
                                            self.businessNameTxtField.text! = ""
                                            self.businessNameArabicTxtField.text! = ""
                                        
                                        }
                                    
        
        })
        
        
        
        
        
        

        
        
    }
    
    @IBOutlet var businessLocationButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let imageSize = CGSize.init(width: 25, height: 25)
        
        let businessNameImage = UIImage(named:"shop")
        businessNameTxtField.addLeftIcon(businessNameImage, frame: frame, imageSize: imageSize)
        businessNameArabicTxtField.addLeftIcon(businessNameImage, frame: frame, imageSize: imageSize)
        
        businessNameTxtField.delegate = self
        businessNameArabicTxtField.delegate = self
        
        
        

    }
    
//    func handleTap(_ sender: UITapGestureRecognizer) {
//       let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "BusinessLocationNavigation") as UIViewController
//        
//       self.present(vc, animated: true, completion: nil)
//        
//        
//        
//        
//    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "businessLocationSegues"
        {
            let navigationController = segue.destination as! UINavigationController
            let googleMapViewController = navigationController.viewControllers[0] as! GoogleMapViewController
            googleMapViewController.googlemapDelgate = self
            
        
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
        
        self.businessNameTxtField.underlined()
        self.businessNameArabicTxtField.underlined()
        self.shopDetailLabel.underlined()
        
        self.registerButtonOutlet.roundedButton()
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getMapDetails(address: String, businessLat: Double, businessLon: Double) {
        businessLocationLabel.text = address
        businessLattitude = businessLat
        businessLongitude = businessLon

    }
    func validateData() -> Bool
    {
        
        if (self.businessNameTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("shopDetails.englishname", comment: ""))
            return false
        }
        else if (self.businessNameArabicTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("shopDetails.arabicname", comment: ""))
            return false
        }
        else if (businessLattitude == 0.0 || businessLongitude == 0.0)
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("shopDetails.buisnessLocation", comment: ""))
            return false
        }
        
        return true
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField == businessNameTxtField)
        {
            businessNameTxtField.resignFirstResponder()
            businessNameArabicTxtField.becomeFirstResponder()
        }
        else if (textField == businessNameArabicTxtField)
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
