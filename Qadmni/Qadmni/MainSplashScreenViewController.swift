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

    }

}
