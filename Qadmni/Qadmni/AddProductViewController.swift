//
//  AddProductViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 28/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet var productDisplay: UIImageView!
    
    @IBAction func productPickerButton(_ sender: UIButton) {
    }
    
    @IBOutlet var categoryPickerTxtField: UITextField!
    
    
    @IBOutlet var productNameEnglishTxt: UITextField!
    
    @IBOutlet var productNameArabicTxt: UITextField!
    
    @IBOutlet var productDetailEnglishTxt: UITextField!
    
    @IBOutlet var productDetailArabicTxt: UITextField!
    
    
    @IBOutlet var priceTxtField: UITextField!
    
    @IBOutlet var productOfferTxt: UITextField!
    
    @IBOutlet var switchOutlet: UISwitch!
    
    @IBAction func availableForSellSwitchAction(_ sender: UISwitch) {
    }
  
    @IBAction func addProductCancelButton(_ sender: UIButton) {
    }
    
    @IBAction func addProductSaveButton(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
