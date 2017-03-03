//
//  TableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 24/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation
import EVReflection
import Alamofire

class TableViewController: UITableViewController , IndicatorInfoProvider {
    var categoryId :Int32 = 0
    var categoryName: String?
    var itemsData: [DisplayItemList]=[]
    let coreData = CoreData()
    /*init(categoryId: Int32 ,categoryName: String,items:[DisplayItemList])
    {
        //super.init()
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.itemsData=items
        super.init(nibName: nil, bundle: nil)
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    public func setInfo(categoryId: Int32 ,categoryName: String?,items:[DisplayItemList]){
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.itemsData=items
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        var initCategory = categoryName == nil ? "" : categoryName
        return IndicatorInfo.init(title: initCategory!)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        self.tableView.register(CustItemListTableViewCell.self, forCellReuseIdentifier: "cellidentifier")
    }
    
    
    // MARK: - Table view data source

    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsData.count
    }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier", for: indexPath) as? CustItemListTableViewCell
    if(cell != nil)
    {
        cell?.itemName.text = self.itemsData[indexPath.row].itemName
        cell?.itemDescription.text = self.itemsData[indexPath.row].itemDesc
        cell?.distanceLabel.text = self.itemsData[indexPath.row].producerData.distance
        cell?.timeLabel.text = self.itemsData[indexPath.row].producerData.time
        cell?.producerNameLabel.text = self.itemsData[indexPath.row].producerData.businessName
        cell?.offerLabel.text = self.itemsData[indexPath.row].offerText
        cell?.itemName.text = self.itemsData[indexPath.row].itemName
        let amountString : String = String(self.itemsData[indexPath.row].unitPrice)
        cell?.amountLabel.text = amountString
        let reviewString : String = String(self.itemsData[indexPath.row].reviews)
        cell?.reviewLabel.text = reviewString + " Review"
        let rating : Double = Double(self.itemsData[indexPath.row].rating)!
        cell?.itemRatingView.rating = rating
        
        let url = URL(string:self.itemsData[indexPath.row].imageUrl)
        if(url == nil){}
        else
        {
        let data = NSData(contentsOf:url!)
            cell?.itemImage.image = UIImage(data:data as! Data)
        }
        
        cell?.qautityLabel.text = String(self.itemsData[indexPath.row].itemQuantity)
        cell?.stepperValue.tag = indexPath.row
        cell?.stepperValue.addTarget(self, action:#selector(stepperTapped(sender:)), for: .touchUpInside)
            }
          return cell!
    }
    
    func stepperTapped(sender : UIStepper)
    {
        itemsData[sender.tag].itemQuantity = Int32(sender.value)
        let cartModel:MyCartModel=MyCartModel()
        cartModel.productId=itemsData[sender.tag].itemId
        cartModel.producerId=itemsData[sender.tag].producerData.producerId
        cartModel.productName=itemsData[sender.tag].itemName
        cartModel.productQuantity = Int16(itemsData[sender.tag].itemQuantity)
        cartModel.unitPrice=itemsData[sender.tag].unitPrice
        coreData.storeUserData(cartModel: cartModel)
        tableView.reloadData()
        
    
    }
    

  
}
