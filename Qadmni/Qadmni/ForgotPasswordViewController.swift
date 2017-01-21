//
//  ForgotPasswordViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 21/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var forgotPasswordButtonOutlet: UIButton!
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.subView.roundedView()
       
        self.forgotPasswordButtonOutlet.roundedButton()
      
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
