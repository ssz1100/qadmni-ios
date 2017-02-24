//
//  ProductListViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 30/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import SWRevealViewController

class ProductListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var vendorItemResponseModel : [VendorItemResponseModel] = []
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addNewProductView: UIView!
    
    @IBOutlet var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuButton.target = revealViewController()
        self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
                addNewProductView.addGestureRecognizer(tap)
        
                addNewProductView.isUserInteractionEnabled = true
        
                self.addNewProductView.addGestureRecognizer(tap)
        
        let vendorItemUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let vendorItemData = VendorItemRequestmodel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorItems(vendorDataRequest: vendorItemData,
                                  vendorUserRequest: vendorItemUser,
                                  vendorLangCodeRequest: vendorLangCode,
                                  completionHandler: {
                                    response in
                                    self.vendorItemResponseModel = response as! [VendorItemResponseModel]
                                    self.tableView.reloadData()
                                
        
        })
        
        
        

    }
    
        func handleTap(_ sender: UITapGestureRecognizer) {
           let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "AddProductViewController") as UIViewController
    
           self.present(vc, animated: true, completion: nil)
    
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorItemResponseModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductListTableViewCell
        
        cell.displayProductName.text? = self.vendorItemResponseModel[indexPath.row].itemName
        let price:Double = self.vendorItemResponseModel[indexPath.row].price
        let priceString:String = String(format:"%.2f", price)
        cell.productPrice.text? = priceString
        cell.categoryTypeLabel.text? = self.vendorItemResponseModel[indexPath.row].category
        cell.detailProductLabel.text? = self.vendorItemResponseModel[indexPath.row].itemDesc
        let url = URL(string:self.vendorItemResponseModel[indexPath.row].imageUrl)
        if(url == nil){}
        else
        {
            let data = NSData(contentsOf:url!)
             cell.displayProductImage.image = UIImage(data:data as! Data)
        }
        let productAvailable: Int = self.vendorItemResponseModel[indexPath.row].availableForSale
            if (productAvailable == 1)
            {
                cell.productAvailableLabel.text = "Available for Sale"
        }
        else
            {
        cell.productAvailableLabel.text = "Not Available for sale"
        }
        
        return cell
        
    }
    

    

}