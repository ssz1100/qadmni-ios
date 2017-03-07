//
//  UserOrderHistoryViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 03/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import Foundation
import XLPagerTabStrip
import MBProgressHUD

class UserOrderHistoryViewController: ButtonBarPagerTabStripViewController {
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(vc, animated: true, completion: nil)
        }
    
   
     let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)

    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .preferredFont(forTextStyle: UIFontTextStyle.callout)         //.boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor =  self?.purpleInspireColor
               }
        super.viewDidLoad()
        self.settings.style.selectedBarHeight = 2
        self.settings.style.selectedBarBackgroundColor = UIColor.gray
        PagerTabStripBehaviour.progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let liveOrder = storyboard.instantiateViewController(withIdentifier: "LiveOrderTableViewController")
        let pastOrder = storyboard.instantiateViewController(withIdentifier: "PastOrderTableViewController") 
        return[liveOrder,pastOrder]
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool)
    {
        
        
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int)
    {
    }
    



   
}
