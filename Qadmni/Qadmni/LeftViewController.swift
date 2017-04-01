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
    @IBOutlet var userEmailIdLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    var menuNameArray:Array = [String]()
    var menuIconImage :Array = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.roundedImageView()

        if(userDefaultManager.getLanguageCode() == "En")
        {
            
            menuNameArray = ["My Cart","My Orders","My Favourites","My Profile","Settings","Partner Login","Logout"]
        }else{
            menuNameArray = ["دخول الشريك","طلباتي","تفضيلاتي","ملفي","الضبط","دخول الشريك","اخرج"]
        }
        if(userDefaultManager.getUserType() == "other")
        {
            menuNameArray.remove(at: 6)
        }
        menuIconImage = [UIImage(named:"shoppingcart")!,UIImage(named:"basket")!,UIImage(named:"favourites")!,UIImage(named:"profile")!,UIImage(named:"setting")!,UIImage(named:"shop")!,UIImage(named:"logout")!]
        userNameLabel.text=userDefaultManager.getUserName()
        userEmailIdLabel.text = userDefaultManager.getVendorEmailId()
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
            if(userDefaultManager.getUserType() == "other")
            {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
            }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "UserOrderHistoryNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            }
        }
        else if (indexPath as NSIndexPath).row == 2
        {
            if(userDefaultManager.getUserType() == "other")
            {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
            }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "MyFavouritesNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            }
        }

        else if (indexPath as NSIndexPath).row == 3
        {
            if(userDefaultManager.getUserType() == "other")
            {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
            }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "MyProfileNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            }
            
        }
        else if (indexPath as NSIndexPath).row == 4
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "UserSettingNavigation") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        }

        else if (indexPath as NSIndexPath).row == 5
        {
            if(userDefaultManager.getUserType() == "other")
            {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
            }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VendorLoginViewController")
            self.present(vc, animated: true, completion: nil)
            }
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
