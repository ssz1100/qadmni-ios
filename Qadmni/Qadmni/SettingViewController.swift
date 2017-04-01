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
    var languageArray = ["English","العربية"]
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    
    @IBOutlet var subView: UIView!
    @IBOutlet var launguageTxtField: UITextField!

    @IBAction func launguageTxtFieldAction(_ sender: UITextField) {
    }
    
    @IBAction func SaveSettingButtonTapped(_ sender: UIButton) {
       
     self.saveButton()
        
    }
  
    
    @IBAction func backButtontapped(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.launguageTxtField.inputView = self.pickerView

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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func saveButton()
    {
       
        let languageStr : String = self.launguageTxtField.text!
         print("Save button Tapped")
        if(languageStr == "")
        {
            self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("setting.selectLanguage", comment: ""))
        }else
        {
            if (languageStr == "English"){
                self.userDefaultManager.setLanguageCode(languageCode: "En")
                LanguageManager.sharedInstance.setLocale("en")
            }else{
                self.userDefaultManager.setLanguageCode(languageCode: "Ar")
                LanguageManager.sharedInstance.setLocale("ar")
            }
            
            let alertView = UIAlertController.init(title: NSLocalizedString("setting.settingSaved", comment: ""), message: NSLocalizedString("setting.savedMessage", comment: ""), preferredStyle: .alert)
            let callActionHandler = { (action:UIAlertAction!) -> Void in
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }
            let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
            alertView.addAction(defaultAction)
            alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
            self.present(alertView, animated: true)

            }
            }
    
    
    

   
}
