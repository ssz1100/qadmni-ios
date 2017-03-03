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
import CoreLocation
import Alamofire
import EVReflection

class QuickStartViewController: ButtonBarPagerTabStripViewController, CLLocationManagerDelegate
    
{
    var initialLoading : Bool = true
    let locationManager = CLLocationManager()
    var customerLattitude : Double = 0
    var customerLongitude : Double = 0
    let coreData = CoreData()
    
    var categoryListGroup = DispatchGroup()
    var categoryArray : [CustCategoryListResModel] = []
    var itemList:[DisplayItemList]=[]
    @IBOutlet weak var menuButton: UIBarButtonItem!

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
        
        self.menuButton.target = revealViewController()
        self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
       self.settings.style.selectedBarHeight = 2
     self.settings.style.selectedBarBackgroundColor = UIColor.gray
        PagerTabStripBehaviour.progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
    
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
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tableView = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
            tableView.setInfo(categoryId: 0, categoryName: nil, items: [])

            //let tableView : TableViewController = TableViewController(categoryId: 0, categoryName:"",items:[])
            controllerList.append(tableView)
        }else{
            controllerList = self.generateViewControllerList(categoryList: categoryArray)
        }
                return controllerList
 }

    
private func generateViewControllerList(categoryList:[CustCategoryListResModel] )-> [UIViewController]
 {
    
    var vc : [UIViewController] = []
    
    for category:CustCategoryListResModel in categoryList {
        var items:[DisplayItemList]=[]
        items = getItemsByCategory(categoryId:category.categoryId)
        //var tableView : TableViewController = TableViewController.init(categoryId: Int32(category.categoryId), categoryName: category.category,items:items)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        tableView.setInfo(categoryId: Int32(category.categoryId), categoryName: category.category,items:items)
        
        vc.append(tableView)
          }
    return vc

}

    func getItemsByCategory(categoryId:Int)->[DisplayItemList]
    {
        var items:[DisplayItemList]=[]
        for item in self.itemList
        {
            if(item.categoryId==categoryId)
            {
                items.append(item)
            }
        }
        return items
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool)
     {
    
    
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int)
    {
    }


    // Mark :- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        customerLattitude = 18.5248902//locValue.latitude
        customerLongitude = 73.7225364//locValue.longitude
        if(customerLattitude>0&&customerLongitude>0)
        {
            locationManager.stopUpdatingLocation()
            let custItemListUser = CustomerUserRequestModel()
            let custItemListData = CustItemListReqModel()
            let custLangCode = CustomerLangCodeRequestModel()
            custItemListData.categoryId = 0
            let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
            serviceFacadeUser.CustomerItemlist(customerDataRequest: custItemListData,
                                               customerUserRequest: custItemListUser,
                                               customerLangCodeRequest: custLangCode,
                                               completionHandler: {
                                                response  in
                                                //                                            self.getDistanceAndTime(custLat: self.customerLattitude, custLong: self.customerLongitude, producerLat:(response?.producerLocations[0].businessLat)!, producerLong: (response?.producerLocations[0].businessLong)!)
                                                let producerLocationsData : [ProducerLocationModel]=(response?.producerLocations)!
                                                var producerList:[ProducerItemListdataModel]=[]
                                                for producerLocationmodel:ProducerLocationModel in producerLocationsData
                                                {
                                                    var producerListData : ProducerItemListdataModel=ProducerItemListdataModel()
                                                    producerListData.businessLat=producerLocationmodel.businessLat
                                                    producerListData.businessLong=producerLocationmodel.businessLong
                                                    producerListData.businessName=producerLocationmodel.businessName
                                                    producerListData.producerId=producerLocationmodel.producerId
                                                    producerList.append(producerListData)
                                                }
                                                self.getLocationInBack(producers: producerList, items: (response?.itemInfoList)!)
                                                
            })
        }

    }
    
    func getLocationInBack(producers:[ProducerItemListdataModel],items:[ItemInfoModel])
   {
    
    DispatchQueue.global(qos: .background).async {
        print("This is run on the background queue")
        
        for producerModel: ProducerItemListdataModel in producers{
            let googleDistanceUrl : String = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="
            let apiKey : String = "&key="+"AIzaSyA8CA7g54OOFJFaMp9j8FzS0K0uh4azFCM"
            let custCurrentLocation : String = String(self.customerLattitude)+","+String(self.customerLongitude)
           // let producerLocation : String = "&destinations=" + String(producerModel.businessLat)+","+String(producerModel.businessLong)
            let producerLocation : String = "&destinations=18.5319231,73.829899"
            let finalString : String = googleDistanceUrl+custCurrentLocation+producerLocation+apiKey
            
            Alamofire.request(finalString,
                              method: .get,
                              encoding: JSONEncoding.default)
                .responseJSON{
                    response in
                    
                    guard response.result.isSuccess else{
                        return
                    }
//                    guard  let responseValue = response.result.value as? [String : AnyObject]
//                        else{
//                            return
//                    }
                    
                    //debugPrint(responseValue)
                     let dict : NSDictionary = response.result.value  as! NSDictionary
                    var rows: NSArray = dict.value(forKey: "rows") as! NSArray
                    let rowsDict:NSDictionary=rows[0] as! NSDictionary
                    var elements : NSArray = rowsDict.value(forKey: "elements") as! NSArray
                    let elementDist:NSDictionary=elements[0] as! NSDictionary
                  //  var googleDistanceResModel : [GoogleDistanceResModel] = [GoogleDistanceResModel](json:elementDist)
//                   var rows:[GoogleDistanceResModel] = []
                    //rows=EVReflection.setPropertiesfromDictionary(dict, anyObject:rows )
                    let distance:NSDictionary=elementDist.value(forKey: "distance") as! NSDictionary
                    producerModel.distance=distance.value(forKey: "text") as! String
                    producerModel.distanceDouble=distance.value(forKey: "value") as! Double
                    let duration : NSDictionary = elementDist.value(forKey: "duration") as! NSDictionary
                   producerModel.time=duration.value(forKey: "text") as! String
                    print(dict)
                    print(elementDist)
                    
            }
        }
        
        DispatchQueue.main.async {
            print("This is run on the main queue, after the previous code in outer block")
            self.prepareDataForList(producers: producers,items:items)
            }
        }

    }
    
    func prepareDataForList(producers:[ProducerItemListdataModel],items:[ItemInfoModel])
    {
        self.itemList.removeAll()
        print("Ready to prepare data")
        for itemInfo: ItemInfoModel in items{
            let displayItem = DisplayItemList()
            displayItem.itemId=itemInfo.itemId
            displayItem.itemName=itemInfo.itemName
            displayItem.itemDesc=itemInfo.itemDesc
            displayItem.imageUrl=itemInfo.imageUrl
            displayItem.unitPrice=itemInfo.unitPrice
            displayItem.rating=itemInfo.rating
            displayItem.offerText=itemInfo.offerText
            displayItem.categoryId=itemInfo.categoryId
            displayItem.reviews=itemInfo.reviews
            displayItem.itemQuantity = coreData.getItemQuantity(itemId: itemInfo.itemId)
            
            displayItem.producerData=self.getProducerById(producerId:itemInfo.producerId,producers:producers)
            self.itemList.append(displayItem)
            
        }
        
        let custCategoryUser = CustomerUserRequestModel()
        let custCategoryData = CustcategoryListReqModel()
        let custLangCode = CustomerLangCodeRequestModel()
        //var controllerList:[UIViewController] = []
        //var categoryArray : [CustCategoryListResModel] = []
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        
        self.categoryListGroup.enter()
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

    }
    
    func getProducerById(producerId:Int32,producers:[ProducerItemListdataModel]) -> ProducerItemListdataModel
    {
        var producer=ProducerItemListdataModel()
        for producerData in producers
        {
            if(producerData.producerId==producerId)
            {
            producer=producerData}
        }
        return producer
    }
    
}



