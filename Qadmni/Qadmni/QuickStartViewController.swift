//
//  QuickStartViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 23/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import Foundation
import SWRevealViewController
import XLPagerTabStrip

class QuickStartViewController: ButtonBarPagerTabStripViewController
    
{
    var initialLoading : Bool = true
    
    var categoryListGroup = DispatchGroup()
    var categoryArray : [CustCategoryListResModel] = []
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    

    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    
    
    override func viewDidLoad() {
        
        
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
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
//            self.buttonBarView.selectedBar.backgroundColor = UIColor.white
        }
        
        
        
        self.menuButton.target = revealViewController()
        self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        
                                            
        
        let custCategoryUser = CustomerUserRequestModel()
        let custCategoryData = CustcategoryListReqModel()
        let custLangCode = CustomerLangCodeRequestModel()
        //var controllerList:[UIViewController] = []
        //var categoryArray : [CustCategoryListResModel] = []
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        
        //self.categoryListGroup.enter()
        serviceFacadeUser.CustomerCategory(customerDataRequest: custCategoryData,
                                           customerUserRequest: custCategoryUser,
                                           customerLangCodeRequest: custLangCode,
                                           completionHandler:{
                                            response in
                                            
                                            self.categoryArray = response as! [CustCategoryListResModel]
                                            //self.datasource = viewControllers()
                                            self.initialLoading = false
                                            self.reloadPagerTabStripView()
                                            //self.categoryListGroup.leave()
                                            
                                            
                                            
        })
        
        super.viewDidLoad()

        
        
        
//        self.settings.style.selectedBarHeight = 2
//        self.settings.style.selectedBarBackgroundColor = UIColor.gray
        //PagerTabStripBehaviour.progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
        
        
    
    
    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        var controllerList:[UIViewController] = []
        if(initialLoading)
        {
            self.showActivity()
        }
        else{
            self.hideActivity()
        }
        if(categoryArray.count == 0) {
        var tabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") 
        controllerList.append(tabViewController)
        }else{
            controllerList = self.generateViewControllerList(categoryList: categoryArray)
        }
                return controllerList
 
        
        
//        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
//        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
//        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
//        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
//        let child_5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
//        return [child_1, child_2,child_3,child_4,child_5]
//        return[TableViewController(),SecondTableViewController()]
    }

private func generateViewControllerList(categoryList:[CustCategoryListResModel] )-> [UIViewController]
 {
    
    var vc : [UIViewController] = []
    
    for category:CustCategoryListResModel in categoryList {
        var tableView : TableViewController = TableViewController.init(categoryId: Int32(category.categoryId), categoryName: category.category)
//        var categoryTabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
        vc.append(tableView)
          }
    return vc

}


    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool)
     {
    
    
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int)
    {
    }

}
    


