//
//  LeftViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 23/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var menuNameArray:Array = [String]()
    var menuIconImage :Array = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        menuNameArray = ["My Cart","My Orders","My Favourites","My Profile","Setting","Partner Login","Logout"]
        menuIconImage = [UIImage(named:"shoppingcart")!,UIImage(named:"basket")!,UIImage(named:"favourites")!,UIImage(named:"profile")!,UIImage(named:"setting")!,UIImage(named:"shop")!,UIImage(named:"logout")!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeftMenuTableViewCell
        cell.imageIcon.image = menuIconImage[indexPath.row]
        cell.cellLabel.text! = menuNameArray[indexPath.row]
        return cell
        
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
