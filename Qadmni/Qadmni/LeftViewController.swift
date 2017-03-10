//
//  LeftViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 23/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var coreData = CoreData()
    
    @IBOutlet var profileImage: UIImageView!
    var menuNameArray:Array = [String]()
    var menuIconImage :Array = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.roundedImageView()

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "userCartNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        }
        else if (indexPath as NSIndexPath).row == 1
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "UserOrderHistoryNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        }
        else if (indexPath as NSIndexPath).row == 3
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "MyProfileNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        }
        else if (indexPath as NSIndexPath).row == 5
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VendorLoginViewController")
            self.present(vc, animated: true, completion: nil)
        }
        else if (indexPath as NSIndexPath).row == 6
        {
            self.userDefaultManager.getUserDetailClear()
            coreData.deleteMyFavourite()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }

    
    

}
