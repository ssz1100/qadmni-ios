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

class QuickStartViewController: ButtonBarPagerTabStripViewController, CLLocationManagerDelegate,UISearchBarDelegate
    
{
    
    var itemListCallCompleted = false
    //var isLocationUpdated = false
    var selectedTableView : SearchItemDelegate?
    //var selectedTableView : UITableViewController?
    var searchItemDelegate : SearchItemDelegate?
    let mySpecialNotificationKey = "com.Qadmni"
    @IBOutlet var myCartBarItem: UIBarButtonItem!
    
    var initialLoading : Bool = true
    let locationManager = CLLocationManager()
    static var customerLattitude : Double = 24.7136
    static var customerLongitude : Double = 46.6753
    let coreData = CoreData()
    //var tableViewController = TableViewController()
    var searchData : [UIViewController] = []
     var userDefaultManager : UserDefaultManager = UserDefaultManager()
    
    
    var categoryListGroup = DispatchGroup()
    var categoryArray : [CustCategoryListResModel] = []
    var itemList:[DisplayItemList]=[]
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBAction func searchBittonBarItem(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController:nil)
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        self.present(searchController, animated:true, completion: nil)

    }
    
    
    
    var CurrentViewController: SearchItemDelegate {
        get{
            return selectedTableView!
        }
        set{
            selectedTableView = newValue
        }
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
        
        
        let revealController = revealViewController()
        self.menuButton.target = revealController
        if(userDefaultManager.getLanguageCode() == "En")
        {
            self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }else{
            let rearController = self.storyboard?.instantiateViewController(withIdentifier: "LeftViewController")
            revealController?.setRight(rearController, animated: true)
            self.menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        }
      
        
        super.viewDidLoad()
//        if(NetworkUtils.isInternetAvailable())
//        {
//            print("Internet is available")
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            if CLLocationManager.locationServicesEnabled() {
                
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        if(!itemListCallCompleted)
        {
            self.getItemList()
        }

        
            self.settings.style.selectedBarHeight = 2
            self.settings.style.selectedBarBackgroundColor = UIColor.gray
            self.delegate = self
            
           
//        }else{
//            print("Internet is Not available")
//            self.hideActivity()
//            self.showAlertMessage(title: NSLocalizedString("networkError.Label", comment: ""), message: NSLocalizedString("networkError.message", comment: ""))
//        
//        }

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 45))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "qadmni_img_logo_english.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
        setBadge()
        
        NotificationCenter.default.addObserver(self, selector: #selector(QuickStartViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
        
        self.automaticallyAdjustsScrollViewInsets = false
        

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
            //let notifier = ItemNotifier()
            tableView.setInfo(categoryId: 0, categoryName: nil, items: [],parentView : self)
            controllerList.append(tableView)
        }else{
            
           if(userDefaultManager.getLanguageCode() == "Ar")
            {
                categoryArray=categoryArray.reversed()
            }
            controllerList = self.generateViewControllerList(categoryList: categoryArray)
        }
        
        searchData = controllerList
                return controllerList
 }

    
private func generateViewControllerList(categoryList:[CustCategoryListResModel] )-> [UIViewController]
 {
    
    var vc : [UIViewController] = []
    
    for category:CustCategoryListResModel in categoryList {
        print("Name of category from Quick Start : ",category.category)
        var items:[DisplayItemList]=[]
        items = getItemsByCategory(categoryId:category.categoryId)
        //var tableView : TableViewController = TableViewController.init(categoryId: Int32(category.categoryId), categoryName: category.category,items:items)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableView = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        //let notifier = ItemNotifier()
        tableView.setInfo(categoryId: Int32(category.categoryId), categoryName: category.category,items:items,parentView : self)
        
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
        //super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        super.updateIndicator(for: self, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        print("Printing From index : %d to index : %d",fromIndex,toIndex)
    
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int)
    {
        print("From index : %d to index : %d",fromIndex,toIndex)
    }
    


    // Mark :- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
        QuickStartViewController.customerLattitude = locValue.latitude //18.5493561
        QuickStartViewController.customerLongitude = locValue.longitude //73.7871573
        if(QuickStartViewController.customerLattitude>0&&QuickStartViewController.customerLongitude>0)
        {
            locationManager.stopUpdatingLocation()
        }

    }
    
    fileprivate func getItemList()
    {
        itemListCallCompleted = true
        if (!userDefaultManager.isCustomerLoggedIn())
        {
            self.getItemListDetails()
        }else
        {
            coreData.deleteMyFavourite()
            let addfavouriteReqModel = AddfavouriteReqModel()
            let customerAddfavUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
            let customerAddfavLangCode = CustomerLangCodeRequestModel()
            let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
            serviceFacadeUser.customerAddFavourites(customerDataRequest: addfavouriteReqModel,
                                                    customerUserRequest: customerAddfavUser,
                                                    customerLangCodeRequest: customerAddfavLangCode,
                                                    completionHandler: {
                                                        response in
                                                        if (response?.errorCode == 0)
                                                        {
                                                            for item in (response?.itemInfoList)!
                                                            {
                                                                var myFavorite = MyFavouritesModel()
                                                                myFavorite.itemId = item.itemId
                                                                self.coreData.saveUserFavourites(myfavourites: myFavorite)
                                                                
                                                            }
                                                        }else{
                                                            print("No favourite found")
                                                        }
                                                        self.getItemListDetails()
            })
            
        }

    }
    
    fileprivate func getItemListDetails()
    {
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
                                            self.getProducerLocations(producers: producerList, items: (response?.itemInfoList)!)
                                            
        })

    }
    
    fileprivate func getProducerLocations(producers:[ProducerItemListdataModel],items:[ItemInfoModel])
   {
    
    DispatchQueue.global(qos: .background).async {
        print("This is run on the background queue")
        
//        for producerModel: ProducerItemListdataModel in producers{
//        let sourceCoordinate = CLLocation(latitude: self.customerLattitude, longitude: self.customerLongitude)
//        let destinationCoordinate = CLLocation(latitude: producerModel.businessLat, longitude:producerModel.businessLong)
//        
//            let distanceInMeters : Double = sourceCoordinate.distance(from: destinationCoordinate)
//            print(distanceInMeters)
//            let distanceInMiles : Double = (distanceInMeters / 1609.344)
//            producerModel.distance = String(format:"%.2f", distanceInMiles)+"  miles"
//            producerModel.distanceDouble=distanceInMiles
//            print(distanceInMiles)
//            let speed : Double = 11.11
//            let timeInSec = (distanceInMeters/speed)
//            let timeInMin = (timeInSec / 60 )
//             producerModel.time = String(format:"%.0f", timeInMin)+"  min"
//            
//            
//        }
        
        for producerModel: ProducerItemListdataModel in producers{
            let googleDistanceUrl : String = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="
            let apiKey : String = "&key="+"AIzaSyA8CA7g54OOFJFaMp9j8FzS0K0uh4azFCM"
            let custCurrentLocation : String = String(QuickStartViewController.customerLattitude)+","+String(QuickStartViewController.customerLongitude)
            let producerLocation : String = "&destinations="+String(producerModel.businessLat)+","+String(producerModel.businessLong)
            let finalString : String = googleDistanceUrl+custCurrentLocation+producerLocation+apiKey
            print(finalString)
            
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
                    var strDistance : String = ""
                    var doubleDistance : Double = 0
                    var strTime : String = ""
                    
                    do {
                        var status : String = elementDist.value(forKey: "status") as! String
                        if (status == "OK"){
                            let distance:NSDictionary  =  try elementDist.value(forKey: "distance") as! NSDictionary
                            strDistance=distance.value(forKey: "text") as! String
                            doubleDistance=distance.value(forKey: "value") as! Double
                            let duration : NSDictionary = try elementDist.value(forKey: "duration") as! NSDictionary
                            strTime = duration.value(forKey: "text") as! String
                        }else{
                            strDistance = NSLocalizedString("googleDistance.label", comment: "")
                            doubleDistance = 0
                            strTime = NSLocalizedString("notAvailabel.label", comment: "")
                        }
                       
                    } catch{
                        //print("Could not calculate distance \(error), \(error.userInfo)")
                        
                    }
                    
                    producerModel.distance = strDistance
                    producerModel.distanceDouble=doubleDistance
                    producerModel.time = strTime
                    print(dict)
                    print(elementDist)
                    
            }
        }
        
        DispatchQueue.main.async {
            print("This is run on the main queue, after the previous code in outer block")
            self.prepareCategoryItems(producers: producers,items:items)
            }
        }

    }
    
    fileprivate func prepareCategoryItems(producers:[ProducerItemListdataModel],items:[ItemInfoModel])
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
            displayItem.isFavourite = coreData.isMyfavourites(itemId: itemInfo.itemId)
            
            displayItem.producerData=self.getProducerById(producerId:itemInfo.producerId,producers:producers)
            self.itemList.append(displayItem)
            
        }
        
        let custCategoryUser = CustomerUserRequestModel()
        let custCategoryData = CustcategoryListReqModel()
        let custLangCode = CustomerLangCodeRequestModel()
        //var controllerList:[UIViewController] = []
        //var categoryArray : [CustCategoryListResModel] = []
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        
       // self.categoryListGroup.enter()
        serviceFacadeUser.CustomerCategory(customerDataRequest: custCategoryData,
                                           customerUserRequest: custCategoryUser,
                                           customerLangCodeRequest: custLangCode,
                                           completionHandler:{
                                            response in
                                            if(self.categoryArray.count == 0)
                                            {
                                        
                                            self.categoryArray = response as! [CustCategoryListResModel]
                                            //self.datasource = viewControllers()
                                            self.initialLoading = false
                                                self.reloadPagerTabStripView()
                                                if (self.userDefaultManager.getLanguageCode() == "Ar")
                                                {
                                            self.moveToViewController(at: self.categoryArray.count)
                                                }
                                            
                                            }
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
    
    func createSearchBar()
    {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter your search"
       // searchBar.delegate = self
        
    }
func actOnSpecialNotification() {
   print("Nsnotification for quickStartcontroller")
    setBadge()
}
func setBadge()
    {
        var badgeCount : Int = 0
        badgeCount = coreData.getMyCartCount()
        if (badgeCount == 0)
        {
            self.myCartBarItem.removeBadge()
        }
        else{
        self.myCartBarItem.addBadge(number: badgeCount)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("In quickStart searchBarDelegate Implementation")
        //CurrentViewController.getSearchItem(searchText: searchText)
        //if(CurrentViewController != nil)
        //{
        
            CurrentViewController.getSearchItem(searchText: searchText)
        //}
//        if(self.searchItemDelegate != nil)
//        {
//        self.searchItemDelegate?.getSearchItem(searchText: searchText)
//        }
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
      CurrentViewController.getSearchItem(searchText:"")
        //self.searchItemDelegate?.getSearchItem(searchText: "")
    }
   

}
public protocol SearchItemDelegate {
    func getSearchItem(searchText:String)
    
    
}




