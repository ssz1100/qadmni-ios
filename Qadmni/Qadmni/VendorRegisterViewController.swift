//
//  VendorRegisterViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorRegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var subView: UIView!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        subView.layer.borderColor = UIColor.white.cgColor
        subView.layer.borderWidth = 1
        subView.layer.cornerRadius = 10
        subView.layer.masksToBounds = true
        
        self.nameTxtField.underlined()
        self.passwordTxtField.underlined()
        self.confirmPasswordTxtField.underlined()
        self.emailTxtField.underlined()
        self.phoneTxtField.underlined()
        
        self.nextButtonOutlet.roundedButton()
        
        
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
