//
//  UserCartViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class UserCartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,LoginResultDelegate {
    var cartList : [MyCartModel] = []
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    @IBOutlet var tableview: UITableView!
    
    @IBAction func editCartButton(_ sender: UIButton) {
        self.isEditing = !self.isEditing
        }
    
    @IBAction func addMoreButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func proceedToPayButton(_ sender: UIButton) {
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
    
    @IBAction func myCartBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      tableview.delegate = self
      tableview.dataSource = self
        
        self.isEditing = true
        let coreData = CoreData()
        
       cartList =  coreData.getUserCoreDataDetails()
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "proceedToPaySegue" {
//            if(userDefaultManager.getUserType() == "other")
//            {
//                let destinationController = segue.destination as! UserLoginViewController
//                destinationController.resultDelegate = self
//
//            }else{
//            let destinationController = segue.destination as! PlaceOrderViewController
//            }
//            
//            
//            
//        }
//        
//    }
//
    
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
                return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func getResult(result: Bool) {
       
    }

       
    

}
