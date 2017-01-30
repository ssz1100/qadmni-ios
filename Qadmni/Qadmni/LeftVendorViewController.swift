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
    
    var menuNameArray:Array = [String]()
    var menuIconImage :Array = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()

        menuNameArray = ["My Orders","My Profile","Setting","Logout"]
        menuIconImage = [UIImage(named:"basket")!,UIImage(named:"profile")!,UIImage(named:"setting")!,UIImage(named:"logout")!]
    }

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
