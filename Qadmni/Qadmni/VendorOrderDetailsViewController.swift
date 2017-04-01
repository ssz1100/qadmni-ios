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
    var orderStatusConstant = OrderStatusConstant()
    var statusId : Int32 = 0

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
    @IBOutlet var orderStatusLabel: UILabel!
    
    @IBAction func showOnMapButtonTapped(_ sender: UIButton) {
    }
    @IBAction func updateStatusbuttonTapped(_ sender: UIButton) {
        
        let updateStatusUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let updateDelStatusViewController = UpdateDelStatusViewController()
        let vendorLangCode = VendorLangCodeRequestmodel()
        updateDelStatusViewController.orderId = self.vendorOrderResponseModel.orderId
        updateDelStatusViewController.deliveryStatusId = Int(self.statusId)
        self.showActivity()
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.UpdateDeliveryStatus(vendorDataRequest: updateDelStatusViewController,
                                           vendorUserRequest: updateStatusUser,
                                           vendorLangCodeRequest: vendorLangCode,
                                           completionHandler: {
                                            response in
                                            self.hideActivity()
                                            if (response?.errorCode == 0)
                                            {
                                            self.showAlertMessage(title: NSLocalizedString("success.title", comment: ""), message: (response?.message)!)
                                            }else{
                                                self.showAlertMessage(title: NSLocalizedString("serverError", comment: ""), message: (response?.message)!)
                                            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let orderIdString : String = String(self.vendorOrderResponseModel.orderId)
        self.orderIdLabel.text = orderIdString
        self.addressLabel.text = self.vendorOrderResponseModel.deliveryAddress
    
        self.deliveryTypeLabel.text = self.vendorOrderResponseModel.deliveryType
        
        if (self.vendorOrderResponseModel.paymentMode == PaymentMethod.payPal)
        {
            self.paymentModeLabel.text = NSLocalizedString("paypalLabel", comment: "")
        }else if (self.vendorOrderResponseModel.paymentMode == PaymentMethod.cash)
        {
            self.paymentModeLabel.text = NSLocalizedString("cashLabel", comment: "")
        }
        
        if (self.vendorOrderResponseModel.deliveryMethod == DelieveryMethods.homeDeleivery)
        {
            self.deliveryTypeLabel.text = NSLocalizedString("homeDelivery", comment: "")
        }else if (self.vendorOrderResponseModel.deliveryMethod == DelieveryMethods.pickUp)
        {
            self.deliveryTypeLabel.text = NSLocalizedString("pickUpLabel", comment: "")
        }

        self.customerNameLabel.text = self.vendorOrderResponseModel.customerName
        let amountString : String = String(self.vendorOrderResponseModel.amountInSAR)
        self.amountLabel.text = amountString
        
        orderStatusLabel.text = orderStatusConstant.getValueOrderStatus(key: self.vendorOrderResponseModel.currentStatusCode)
        
        
        let serverdateFormatter = DateFormatter()
        serverdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
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
        let statusMessage : String = changeStatusData[row].statusCode
        var readableString : String = ""

        switch (statusMessage) {
        case  orderStatusConstant.readyToPickUp :
            readableString = NSLocalizedString("Readytopickup", comment: "")
            break
        case orderStatusConstant.deliveryInProgress :
            readableString =  NSLocalizedString("Deliveryinprogress", comment: "")
            break
        case orderStatusConstant.orderPlacedCode :
            readableString = NSLocalizedString("Orderplaced", comment: "")
            break
        case orderStatusConstant.pickUpComplete :
            readableString = NSLocalizedString("Orderpickupcomplete", comment: "")
            break
        case orderStatusConstant.timeForPickUpOver :
            readableString = NSLocalizedString("Timeforpickupisover", comment: "")
            break
        default:
            readableString = ""
            break
        }
        return readableString
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let statusMessage : String = changeStatusData[row].statusCode
        statusId = changeStatusData[row].statusId
        var readableString : String = ""
        
        switch (statusMessage) {
        case  orderStatusConstant.readyToPickUp :
            readableString = NSLocalizedString("Readytopickup", comment: "")
            break
        case orderStatusConstant.deliveryInProgress :
            readableString =  NSLocalizedString("Deliveryinprogress", comment: "")
            break
        case orderStatusConstant.orderPlacedCode :
            readableString = NSLocalizedString("Orderplaced", comment: "")
            break
        case orderStatusConstant.pickUpComplete :
            readableString = NSLocalizedString("Orderpickupcomplete", comment: "")
            break
        case orderStatusConstant.timeForPickUpOver :
            readableString = NSLocalizedString("Timeforpickupisover", comment: "")
            break
        default:
            readableString = ""
            break
        }

        self.readyToPickTxtField.text = readableString
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    

   
}
