//
//  ConfirmPayViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 28/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ConfirmPayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PayPalPaymentDelegate {
    
    var custProcessOrderResModel: CustProcessOrderResModel = CustProcessOrderResModel()
    var coreData = CoreData()
    
    var environment:String = ""
    var payPalConfig = PayPalConfiguration() // default
    
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var placeOrderResModel = CustPlaceOrderResModel()
    @IBOutlet var finalPriceLabel: UILabel!
    @IBOutlet var payButtonOutlet: UIButton!
    
    @IBOutlet var itemTableView: UITableView!
    @IBOutlet var serviceTaxTableView: UITableView!
    
   
    @IBAction func payButtonTapped(_ sender: UIButton) {
        let custProcessOrderReqModel = CustProcessOrderReqModel()
        let customerProcessOrderUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        custProcessOrderReqModel.orderId = self.placeOrderResModel.orderId
        custProcessOrderReqModel.orderAmountInSAR = self.placeOrderResModel.totalAmountInSAR
        custProcessOrderReqModel.orderAmountInUSD = self.placeOrderResModel.totalAmountInUSD
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerProcessOrder(customerDataRequest: custProcessOrderReqModel,
                                               customerUserRequest: customerProcessOrderUser,
                                               customerLangCodeRequest: customerLangCode,
                                               completionHandler: {
                                                response in
                                                debugPrint(response)
                                                self.custProcessOrderResModel = response!
                                                
                                                if (self.custProcessOrderResModel.transactionRequired){
                                                // Payppal Integration
                                                    if (self.custProcessOrderResModel.paypalEnvValues.environment == "sandbox")
                                                    {
                                                        self.environment=PayPalEnvironmentSandbox
                                                    }
                                                    else if(self.custProcessOrderResModel.paypalEnvValues.environment=="live")
                                                    {
                                                        self.environment=PayPalEnvironmentProduction
                                                    }
                                                    PayPalMobile.preconnect(withEnvironment: self.environment)
                                                    let amount = NSDecimalNumber.init(value: (self.custProcessOrderResModel.amount))

                                                    let payment = PayPalPayment(amount:amount, currencyCode: (self.custProcessOrderResModel.currency), shortDescription: (self.custProcessOrderResModel.paypalEnvValues.paypalDesc), intent: .sale)
                                                    payment.invoiceNumber = self.custProcessOrderResModel.transactionId
                                                    
                                                    if (payment.processable) {
                                                        let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self )
                                                        self.present(paymentViewController!, animated: true, completion: nil)
                                                    }
                                                    else {
                                                        // This particular payment will always be processable. If, for
                                                        // example, the amount was negative or the shortDescription was
                                                        // empty, this payment wouldn't be processable, and you'd want
                                                        // to handle that here.
                                                        print("Payment not processalbe: \(payment)")
                                                    }
                                                }
                                                else
                                                {
                                                self.confirmOrder(orderId: (self.custProcessOrderResModel.orderId), transactionId: (self.custProcessOrderResModel.transactionId), amountInSAR:self.placeOrderResModel.totalAmountInSAR, amountInUSD: self.placeOrderResModel.totalAmountInUSD, paypalId: "")
                                                
                                                }
        
        })
        

    }
    
    func confirmOrder(orderId:Int32,transactionId : String,amountInSAR : Double,amountInUSD : Double, paypalId : String)
    {
        let custConfirmOrderReqModel = CustConfirmOrderReqModel()
        let customerConfirmOrderUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        custConfirmOrderReqModel.orderId = orderId
        custConfirmOrderReqModel.amountInSAR = amountInSAR
        custConfirmOrderReqModel.amountInUSD = amountInUSD
        custConfirmOrderReqModel.transactionId = transactionId
        custConfirmOrderReqModel.paypalId = paypalId
        self.showActivity()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerConfirmOrder(customerDataRequest: custConfirmOrderReqModel,
                                               customerUserRequest: customerConfirmOrderUser,
                                               customerLangCodeRequest: customerLangCode,
                                               completionHandler: {
                                                response in
                                                self.hideActivity()
                                                debugPrint(response)
                                                if (response?.errorCode == 0)
                                                {
                                                    let alertView = UIAlertController.init(title:NSLocalizedString("success.title", comment: "") , message:NSLocalizedString("confirmOrder.message", comment: "") , preferredStyle: .alert)
                                                    let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                        let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "UserOrderHistoryNavigation") as! UINavigationController
                                                        self.present(vc, animated: true)
                                                        self.coreData.deleteCartData()
                                                    }
                                                    let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
                                                    alertView.addAction(defaultAction)
                                                    alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                                    self.present(alertView, animated: true)
                                                }
                                                else{
                                                    self.showAlertMessage(title: NSLocalizedString("serverError", comment: ""), message: (response?.message)!)
                                                
                                                }
                                                
                                                
        })
    
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        serviceTaxTableView.delegate = self
        let finalPriceString : String = String(self.placeOrderResModel.totalAmountInSAR)
        finalPriceLabel.text = finalPriceString
        let payInUSDString : String = String(self.placeOrderResModel.totalAmountInUSD)
        payButtonOutlet.setTitle(NSLocalizedString("payUSD.label", comment: "")+payInUSDString, for: .normal)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView==self.itemTableView)
        {
            return placeOrderResModel.orderedItems.count
        }
        else{
        return placeOrderResModel.chargeBreakup.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView==self.itemTableView)
        {
          let itemcell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ProcessItemTableViewCell
            itemcell.itemName.text? = self.placeOrderResModel.orderedItems[indexPath.row].itemName
            let priceString : String = String(format:"%.2f",self.placeOrderResModel.orderedItems[indexPath.row].unitPrice )
            itemcell.itemPrice.text? = priceString
            let itemQuantity : String = String(self.placeOrderResModel.orderedItems[indexPath.row].itemQty)
            itemcell.itemQuantity.text = itemQuantity
            
            
            return itemcell
        }
        else{
           let taxcell = tableView.dequeueReusableCell(withIdentifier: "taxcell", for: indexPath) as! ProcessServiceTaxTableViewCell
            taxcell.servicesLabel.text = self.placeOrderResModel.chargeBreakup[indexPath.row].chargeDetails
            let serviceFees : String = String(self.placeOrderResModel.chargeBreakup[indexPath.row].amount)
            taxcell.serviceTaxFees.text = serviceFees
            
            return taxcell
        }
        
        
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            let confirmation : NSDictionary = completedPayment.confirmation as NSDictionary
            let response:NSDictionary=confirmation.value(forKey: "response") as! NSDictionary
            
            let payPalId:String=response.value(forKey: "id") as! String
           
             self.confirmOrder(orderId: (self.custProcessOrderResModel.orderId), transactionId: (self.custProcessOrderResModel.transactionId), amountInSAR:self.placeOrderResModel.totalAmountInSAR, amountInUSD: self.placeOrderResModel.totalAmountInUSD, paypalId: payPalId)
        
        })
    }

   
}
