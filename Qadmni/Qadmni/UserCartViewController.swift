//
//  UserCartViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class UserCartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var cartList : [MyCartModel] = []
    
    @IBOutlet var tableview: UITableView!
    
    @IBAction func editCartButton(_ sender: UIButton) {
    }
    
    @IBAction func addMoreButton(_ sender: UIButton) {
    }
    
    @IBAction func proceedToPayButton(_ sender: UIButton) {
    }
    
    @IBAction func myCartBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      tableview.delegate = self
      tableview.dataSource = self
        let coreData = CoreData()
        
       cartList =  coreData.getUserCoreDataDetails()
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                return cell
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
