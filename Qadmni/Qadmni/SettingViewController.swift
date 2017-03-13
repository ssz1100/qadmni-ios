//
//  SettingViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 28/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let pickerView = UIPickerView()
    var languageArray = ["English","Arabic"]
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    
    @IBOutlet var subView: UIView!
    @IBOutlet var launguageTxtField: UITextField!

    @IBAction func launguageTxtFieldAction(_ sender: UITextField) {
    }
    
    @IBAction func SaveSettingButtonTapped(_ sender: UIButton) {
        let languageStr : String = self.launguageTxtField.text!
        if(languageStr == "")
        {
            self.showAlertMessage(title: "Info", message: "Please Select Language")
        }else if (languageStr == "English")
        {
        self.userDefaultManager.setLanguageCode(languageCode: "En")
            LanguageManager.sharedInstance.setLocale("en")
        }else if (languageStr == "Arabic")
        {
        self.userDefaultManager.setLanguageCode(languageCode: "Ar")
            LanguageManager.sharedInstance.setLocale("ar")
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
  
    
    @IBAction func backButtontapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.launguageTxtField.inputView = self.pickerView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return languageArray.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return languageArray[row]
    
        }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.launguageTxtField.text = languageArray[row]
        self.launguageTxtField.isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    

   
}
