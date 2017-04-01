//
//  UserCartViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class UserCartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,LoginResultDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    var cartList : [MyCartModel] = []
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    let pickerView = UIPickerView()
    var productQuantityArray = ["1","2","3","4","5","6","7","8","9","10"]
    @IBOutlet var tableview: UITableView!
    var editQuantityTxtField : UITextField!
    var quantityLabel : String = ""
    let coreData = CoreData()
    var isEdit : Bool = false

    
    @IBAction func editCartButton(_ sender: UIButton) {
       // self.tableview.setEditing(true, animated: true)
        isEdit = true
        tableview.reloadData()
        }
    
    @IBAction func addMoreButtonBarItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func proceedToPayButton(_ sender: UIButton) {
        if(coreData.getMyCartCount() == 0)
        {
        self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("myCart.message", comment: ""))
        }else{
            if(userDefaultManager.getUserType()=="other")
            {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }else{
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "PlaceOrderViewController") as UIViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
    }
    
    @IBAction func myCartBackButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      tableview.delegate = self
      tableview.dataSource = self
        
        self.isEditing = true
        let coreData = CoreData()
        
       cartList =  coreData.getUserCoreDataDetails()
       
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCartTableViewCell
        cell.productLabel.text = cartList[indexPath.row].productName
        let price:String = String(format:"%.2f",cartList[indexPath.row].unitPrice)
        cell.priceLabel.text = price
        let quantity : String = String(cartList[indexPath.row].productQuantity)
        cell.quantitylabel.text = quantity
        quantityLabel = quantity
        
        
        if (isEdit)
        {
        cell.quantitylabel.textColor = .blue
            cell.quantitylabel.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(productLabelTapped(sender:)))
            
            cell.quantitylabel.addGestureRecognizer(tap)
            
            cell.quantitylabel.isUserInteractionEnabled = true
        
        }
        
                return cell
    }
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Deleted")
//            
//        }
//    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//    }
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    
    
    
    func getResult(result: Bool) {
       
    }
    func productLabelTapped(sender:UITapGestureRecognizer)
    {
        let alertView = UIAlertController.init(title: NSLocalizedString("myCart.productQuantityLabel", comment: ""), message: "", preferredStyle: .alert)
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let updatedCart : MyCartModel = self.cartList[(sender.view?.tag)!]
            updatedCart.productQuantity = Int16(self.editQuantityTxtField.text!)!
            print(updatedCart.productQuantity)
            self.coreData.storeUserData(cartModel: updatedCart)
            self.tableview.reloadData()
        }
        let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
        let defaultAction2 = UIAlertAction.init(title:NSLocalizedString("cancelLabel", comment: ""), style: .destructive, handler: nil)
        alertView.addAction(defaultAction)
        alertView.addAction(defaultAction2)
        alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
        alertView.addTextField(configurationHandler: { (textField :UITextField) in
            textField.text = self.quantityLabel
            self.createTextField(textField: textField)
            
        })
        self.present(alertView, animated: true)
    
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return productQuantityArray.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return productQuantityArray[row]
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.editQuantityTxtField.text = productQuantityArray[row]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    private func createTextField(textField :UITextField)
    {
        textField.placeholder = NSLocalizedString("myCart.enterProductQuantity", comment: "")
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        textField.inputView = self.pickerView
        textField.borderStyle = UITextBorderStyle.roundedRect
        self.editQuantityTxtField = textField
    
    }




    

}
