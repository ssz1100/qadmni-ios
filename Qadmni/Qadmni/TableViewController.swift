//
//  TableViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 24/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation
import EVReflection
import Alamofire

class TableViewController: UITableViewController , IndicatorInfoProvider,SearchItemDelegate {
    let mySpecialNotificationKey = "com.Qadmni"
    var categoryId :Int32 = 0
    var categoryName: String?
    var filteredItemList: [DisplayItemList]=[]
    var originalItemList: [DisplayItemList]=[]
    var filteredOutput :[DisplayItemList]=[]
    let coreData = CoreData()
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var sortType = SortByConstant()
    var isFilterData:Bool = false
    var searchResult : Bool = false
    var parentView : QuickStartViewController? = nil
    //var cache = NSCache()
    
   // var quickStartViewController = QuickStartViewController()
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
////        fatalError("init(coder:) has not been implemented")
//    }
    
    public func setInfo(categoryId: Int32 ,categoryName: String?,items:[DisplayItemList],parentView : QuickStartViewController)
    {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.originalItemList = items
        self.filteredItemList = items
        print("Items %d in %d category", originalItemList.count, categoryId)
        self.parentView = parentView
        //self.parentView?.searchItemDelegate = self
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        let initCategory = categoryName == nil ? "" : categoryName
        return IndicatorInfo.init(title: initCategory!)
    }
   


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
         NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.updateNotificationCartCount), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.showActivity()
    }
    override func viewWillDisappear(_ animated: Bool) {
       // self.hideActivity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //var controller: QuickStartViewController = parentView as! QuickStartViewController
        parentView?.CurrentViewController = self
        //controller.CurrentViewController = self
        
        
        self.filteredItemList=self.originalItemList
        let filterByPrice :Double = self.userDefaultManager.getFiltertedByPrice()
        if (filterByPrice != 0){
        self.filteredItemList=self.filteredItemList.filter({ (item) -> Bool in
            return item.unitPrice <= filterByPrice
            
        })
        }
        
        let filterByDistance :Double = self.userDefaultManager.getFiltertedByDistance()
        if (filterByDistance > 1){
            self.filteredItemList=self.filteredItemList.filter({ (item) -> Bool in
                return item.producerData.distanceDouble <= filterByDistance
            })
        }

        
        let selectedSort : Int = self.userDefaultManager.getSelectedSortBy()
        
        if(selectedSort == sortType.distanceSort)
        {
            self.filteredItemList.sort(by: { (item1, item2) -> Bool in
                return item1.producerData.distanceDouble < item2.producerData.distanceDouble
            })
        }else if (selectedSort == sortType.priceSort)
        {
            self.filteredItemList.sort(by: { (item1, item2) -> Bool in
                return item1.unitPrice < item2.unitPrice
            })
        }
        else if (selectedSort == sortType.reviewSort)
        {
            self.filteredItemList.sort(by: { (item1, item2) -> Bool in
                return item1.reviews > item2.reviews
            })
        }
        self.filteredOutput = self.filteredItemList
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(searchResult)
//        {
//            return filteredData.count
//        }
        return filteredItemList.count
    }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier", for: indexPath) as? CustItemListTableViewCell
    if(cell != nil)
    {
//        if(indexPath.row == 0)
//        {
//            self.showActivity()
//        }
//        if(indexPath.row == self.filteredItemList.count - 1)
//        {
//        self.hideActivity()
//        }
//        
        cell?.contentView.backgroundColor = .white
        cell?.itemName.text = self.filteredItemList[indexPath.row].itemName
        cell?.itemDescription.text = self.filteredItemList[indexPath.row].itemDesc
        cell?.distanceLabel.text = self.filteredItemList[indexPath.row].producerData.distance
        cell?.timeLabel.text = self.filteredItemList[indexPath.row].producerData.time
        cell?.producerNameLabel.text = self.filteredItemList[indexPath.row].producerData.businessName
        if(self.filteredItemList[indexPath.row].offerText == "")
        {
            cell?.offerLabel.isHidden = true
            cell?.offerImageView.isHidden = true
        }
        cell?.offerLabel.text = self.filteredItemList[indexPath.row].offerText
        cell?.itemName.text = self.filteredItemList[indexPath.row].itemName
        let amountString : String = String(self.filteredItemList[indexPath.row].unitPrice)
        cell?.amountLabel.text = amountString
        let reviewString : String = String(self.filteredItemList[indexPath.row].reviews)
        cell?.reviewLabel.text = reviewString
        let rating : Double = Double(self.filteredItemList[indexPath.row].rating)!
        cell?.itemRatingView.rating = rating
        
       // cell?.itemImage.image = UIImage(named: "ice_cream_one.jpg")
        cell?.itemImage.downloadedFrom(link: self.filteredItemList[indexPath.row].imageUrl)
        //let url = URL(string:self.filteredItemList[indexPath.row].imageUrl)
//        if(url == nil){}
//        else
//        {
        //let data = NSData(contentsOf:url!)
            //cell?.itemImage = imageFromUrl(url) //= UIImage(data:data as! Data)
        //}
        
//        DispatchQueue.global(qos: .background).async (execute : {
//            DispatchQueue.main.async {
//                do{
//                    if(url == nil){}else{
//                    let data = try NSData(contentsOf:url!) as Data
//                    cell?.itemImage.image =  UIImage(data: data)
//                    }
//                } catch let error as NSError{
//                
//                }
//                
//                }
//            })
        
        
        cell?.qautityLabel.text = String(self.filteredItemList[indexPath.row].itemQuantity)
        if (self.filteredItemList[indexPath.row].isFavourite)
        {
            cell?.favImage.image = UIImage(named :"favouritesSelected")
        }else{
            cell?.favImage.image = UIImage(named :"favourites")
        }
        cell?.stepperValue.tag = indexPath.row
        cell?.stepperValue.addTarget(self, action:#selector(stepperTapped(sender:)), for: .touchUpInside)
        cell?.favImage.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe(sender:)))

        cell?.favImage.addGestureRecognizer(tap)
        cell?.favImage.isUserInteractionEnabled = true

            }
          return cell!
    }
    
    func stepperTapped(sender : UIStepper)
    {
        filteredItemList[sender.tag].itemQuantity = Int32(sender.value)
        let cartModel:MyCartModel=MyCartModel()
        cartModel.productId=filteredItemList[sender.tag].itemId
        cartModel.producerId=filteredItemList[sender.tag].producerData.producerId
        cartModel.productName=filteredItemList[sender.tag].itemName
        cartModel.productQuantity = Int16(filteredItemList[sender.tag].itemQuantity)
        cartModel.unitPrice=filteredItemList[sender.tag].unitPrice
        coreData.storeUserData(cartModel: cartModel)

        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
        tableView.reloadData()
        
    
    }
    func tappedMe(sender:UITapGestureRecognizer)
    {
        
        
        let itemInfoData : DisplayItemList = filteredItemList[(sender.view?.tag)!]
        let addRemoveFavReqModel = AddRemoveFavReqModel()
        addRemoveFavReqModel.productId = itemInfoData.itemId
        if (itemInfoData.isFavourite)
        {
        addRemoveFavReqModel.favFlag = 0
        }
        else{
        addRemoveFavReqModel.favFlag = 1
        }
        
        if(self.userDefaultManager.isCustomerLoggedIn())
        {
        
        let customerAddfavUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerAddfavLangCode = CustomerLangCodeRequestModel()
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.customerAddRemoveFavourites(customerDataRequest: addRemoveFavReqModel,
                                                      customerUserRequest: customerAddfavUser,
                                                      customerLangCodeRequest: customerAddfavLangCode,
                                                      completionHandler: {
                                                        response in
                                                        
                                                        if(response?.errorCode == 0)
                                                        {
                                                        itemInfoData.isFavourite = !itemInfoData.isFavourite
                                                            if(itemInfoData.isFavourite)
                                                            {
                                                                let myfavourites = MyFavouritesModel()
                                                                    myfavourites.itemId = itemInfoData.itemId
                                                            self.coreData.saveUserFavourites(myfavourites: myfavourites)
                                                            }else{
                                                                self.coreData.deletemyFavouriteItem(itemId: itemInfoData.itemId)
                                                            
                                                            }
                                                            self.tableView.reloadData()
                                                        }
                                                        
        })

        }
    }
    
    func updateNotificationCartCount() {
     //print("Nsnotification for tableViewcontroller")
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
//    {
//        var filterOutput = [DisplayItemList]
//        if (isFilterData)
//        {
//            filterOutput = filteredData
//        }
//        else{
//            filterOutput = itemsData
//        }
//        
//            filterOutput = filterOutput.filter({ (item) -> Bool in
//                let searchByName: NSString = item.itemName as NSString
//                let searchByDesc : NSString = item.itemDesc as NSString
//                let nameRange = searchByName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//                let descRange = searchByDesc.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//                return nameRange.location != NSNotFound
//                return descRange.location != NSNotFound
//            })
//            if(filterOutput.count == 0){
//                searchResult = false
//            } else {
//                searchResult = true
//            }
//        self.tableView.reloadData()
//    }
    
    func getSearchItem(searchText: String) {
        print("In tableview searchBar")
        self.filteredItemList = self.filteredOutput
        if(searchText != ""){
        self.filteredItemList = self.filteredItemList.filter(
            {
                item in
                return self.searchItem(item: item, searchText: searchText)
        })
        }
        
        //                        if(itemData.count == 0){
        //                            searchResult = false
        //                        } else {
        //                            searchResult = true
        //                        }
        self.tableView.reloadData()
    }
    
    fileprivate func searchItem(item:DisplayItemList , searchText : String) -> Bool
    {
    
        let searchByName: NSString = item.itemName as NSString
        let searchByDesc : NSString = item.itemDesc as NSString
        let nameRange = searchByName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
        let descRange = searchByDesc.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
        
        
        return nameRange.location != NSNotFound || descRange.location != NSNotFound
    
    }
    
    /*fileprivate func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?,_ url: String) -> ()) {
        DispatchQueue.global(qos: .background).async { () in
            var data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async(execute: {() in
                    completionHandler(image, urlString)
                })
                return
            }
            
            var downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: urlString) as! URLRequest, completionHandler: {(data: Data!, response: URLResponse!, error: Error!) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            
            downloadTask.resume()
        }
        
    }*/
    
   }



