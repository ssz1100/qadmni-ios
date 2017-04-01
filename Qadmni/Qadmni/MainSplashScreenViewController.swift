//
//  MainSplashScreenViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 22/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class MainSplashScreenViewController: UIViewController {

    @IBOutlet var splashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 0.6, animations: {
                        self.splashImage.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
                    }, completion: { (finish) in
                        UIView.animate(withDuration: 0.6, animations: {
                            self.splashImage.transform = CGAffineTransform.identity
                        })
                    })

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
