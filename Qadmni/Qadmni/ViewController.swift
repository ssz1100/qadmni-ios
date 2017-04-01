//
//  ViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 18/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,LoginResultDelegate {
    @IBOutlet var imageView: UIImageView!
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Locale.current.languageCode as Any)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            
            let destinationController = segue.destination as! UserLoginViewController
            destinationController.resultDelegate = self
            
            
        }
        
    }

    func getResult(result: Bool) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(vc, animated: true, completion: nil)
    }
    }








