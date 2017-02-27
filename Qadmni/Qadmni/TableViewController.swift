//
//  TableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 24/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TableViewController: UITableViewController , IndicatorInfoProvider {
    var categoryId :Int32 = 0
    var categoryName: String = ""
    
    init(categoryId: Int32 ,categoryName: String)
    {
        //super.init()
        self.categoryId = categoryId
        self.categoryName = categoryName
        super.init(style: UITableViewStyle.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        return IndicatorInfo.init(title: categoryName)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let custItemListUser = CustomerUserRequestModel()
        let custItemListData = CustItemListReqModel()
        let custLangCode = CustomerLangCodeRequestModel()
        custItemListData.categoryId = categoryId
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerItemlist(customerDataRequest: custItemListData,
                                           customerUserRequest: custItemListUser,
                                           customerLangCodeRequest: custLangCode,
                                           completionHandler: {
                                            response  in
        })
        
        
        
                
        
        
            }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustItemListTableViewCell

        // Configure the cell...

        return cell
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
