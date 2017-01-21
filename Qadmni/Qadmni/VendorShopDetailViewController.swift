//
//  VendorShopDetailViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorShopDetailViewController: UIViewController {
    @IBOutlet weak var shopDetailLabel: UILabel!
    
    @IBOutlet weak var businessNameTxtField: UITextField!
    
    @IBOutlet weak var businessLocationTxtField: UITextField!
    
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    @IBAction func shopRegisterButton(_ sender: UIButton) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        let imageSize = CGSize.init(width: 25, height: 25)
        
        let businessNameImage = UIImage(named:"shop")
        businessNameTxtField.addLeftIcon(businessNameImage, frame: frame, imageSize: imageSize)
        let businesslocationImage = UIImage(named:"location")
        businessLocationTxtField.addLeftIcon(businesslocationImage, frame: frame, imageSize: imageSize)
        

    }
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
        
        self.businessNameTxtField.underlined()
        self.shopDetailLabel.underlined()
        
        self.registerButtonOutlet.roundedButton()
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
