//
//  MyProfileViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 31/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var nameTxtField: UITextField!

    @IBOutlet var emailtxtField: UITextField!
    
    @IBOutlet var passwordTxtField: UITextField!
    
    @IBOutlet var addressTxtField: UITextField!
    
    
    @IBAction func saveProfileButton(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews()
    {
        profileImage.roundedImageView()
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
