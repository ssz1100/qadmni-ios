//
//  LeftVendorViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 30/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import SWRevealViewController

class LeftVendorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var vendorTableView: UITableView!
    
    @IBOutlet var leftProfileImage: UIImageView!
    
    var menuNameArray:Array = [String]()
    var menuIconImage :Array = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()

        menuNameArray = ["My Orders","My Profile","Setting","Logout"]
        menuIconImage = [UIImage(named:"basket")!,UIImage(named:"profile")!,UIImage(named:"setting")!,UIImage(named:"logout")!]
        
        leftProfileImage.roundedImageView()
        vendorTableView.delegate = self
        vendorTableView.dataSource = self
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "OrderStatusNavigation"
//        {
//            let navigationController = segue.destination as! UINavigationController
//            let destinationController = navigationController.viewControllers[0] as! VendorOrderStatusTableViewController
//            
//            self.navigationController?.pushViewController(destinationController, animated: true)
//            
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeftVendorTableViewCell
        
        cell.imageIcon.image = menuIconImage[indexPath.row]
        cell.cellLabel.text! = menuNameArray[indexPath.row]
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "OrderStatusNavigation") as! UINavigationController
           
            self.present(vc, animated: true, completion: nil)


        
        }
    }

   
}
