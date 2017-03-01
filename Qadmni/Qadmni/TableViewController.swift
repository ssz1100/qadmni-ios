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
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        let url = URL(string:self.itemsData[indexPath.row].imageUrl)
        if(url == nil){}
        else
        {
        let data = NSData(contentsOf:url!)
            cell?.itemImage.image = UIImage(data:data as! Data)
        }
    
        
        
        
        
        
    
    
    }
  
    
    
    

        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
