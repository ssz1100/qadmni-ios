//
//  VendorOrderDetailsViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 31/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorOrderDetailsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var vendorOrderResponseModel = VendorOrderResponseModel()
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var changeStatusData : [UpdateStatusModel] = []
    let pickerView = UIPickerView()

    @IBOutlet var readyToPickTxtField: UITextField!
    @IBOutlet var changeStatusView: UIView!
    @IBOutlet var giftMessageView: UIView!
    @IBOutlet var orderIdLabel: UILabel!
    @IBOutlet var orderDateLabel: UILabel!
    @IBOutlet var paymentModeLabel: UILabel!
    @IBOutlet var deliveryTypeLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var giftMessageLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var statusImageview: UIImageView!
    
    @IBAction func showOnMapButtonTapped(_ sender: UIButton) {
    }
    @IBAction func updateStatusbuttonTapped(_ sender: UIButton) {
        
        let updateStatusUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let updateDelStatusViewController = UpdateDelStatusViewController()
        let vendorLangCode = VendorLangCodeRequestmodel()
        updateDelStatusViewController.orderId = self.vendorOrderResponseModel.orderId
        updateDelStatusViewController.deliveryStatusId = self.vendorOrderResponseModel.deliveryStatusId
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.UpdateDeliveryStatus(vendorDataRequest: updateDelStatusViewController,
                                           vendorUserRequest: updateStatusUser,
                                           vendorLangCodeRequest: vendorLangCode,
                                           completionHandler: {
                                            response in
        
        
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let orderIdString : String = String(self.vendorOrderResponseModel.orderId)
        self.orderIdLabel.text = orderIdString
        self.addressLabel.text = self.vendorOrderResponseModel.deliveryAddress
        self.paymentModeLabel.text = self.vendorOrderResponseModel.paymentMethod
        self.deliveryTypeLabel.text = self.vendorOrderResponseModel.deliveryType
        self.customerNameLabel.text = self.vendorOrderResponseModel.customerName
        let amountString : String = String(self.vendorOrderResponseModel.amountInSAR)
        self.amountLabel.text = amountString
        
        
        let serverdateFormatter = DateFormatter()
        serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let strDate:String = self.vendorOrderResponseModel.orderDate
        let date = serverdateFormatter.date(from: strDate)
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let displayDate = displayDateFormatter.string(from: date!)
        self.orderDateLabel.text = displayDate
        
        if (self.vendorOrderResponseModel.stageNo == 1)
        {
            self.statusImageview.image = UIImage(named: "form_wiz_1.jpg")
        }else if (self.vendorOrderResponseModel.stageNo == 2)
        {
        self.statusImageview.image = UIImage(named: "form_wiz_2.jpg")
        }else
        {
        self.statusImageview.image = UIImage(named: "form_wiz_3.jpg")
        }
        
        
        
        if (self.vendorOrderResponseModel.canUpdateStatus == false)
        {
        self.changeStatusView.isHidden = true
        }
        else{
            
            self.changeStatusData = self.vendorOrderResponseModel.updatableStatusCodes
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.readyToPickTxtField.inputView = self.pickerView
        
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StatusGoogleSegue" {
            
            let destinationController = segue.destination as! StatusGoogleMapViewController
            destinationController.custLatitude = self.vendorOrderResponseModel.deliveryLat
            destinationController.custLongitude = self.vendorOrderResponseModel.deliveryLong
            destinationController.custName = self.vendorOrderResponseModel.customerName
            destinationController.custAddress = self.vendorOrderResponseModel.deliveryAddress
            
            }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return changeStatusData.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return changeStatusData[row].statusCode
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.readyToPickTxtField.text = changeStatusData[row].statusCode
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    

   
}
