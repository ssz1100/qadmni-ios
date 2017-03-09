//
//  PlaceOrderViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class PlaceOrderViewController: UIViewController,GoogleMapDelegate ,CLLocationManagerDelegate, GMSMapViewDelegate,OnCheckClickedDelegate {
    var googleMapsView: GMSMapView!
    var location = CLLocation()
    
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var coreData : CoreData = CoreData()
    var textString : String = ""
    
    var productInfo : [ItemRequestModel] = []
    var deliveryAddress : String = ""
    var deliveryMethod : String = ""
    var deliverySchedule : Int32 = 0
    var checkDeliverySchedule : Bool=false
    var paymentMethod : String = ""
    var isGift: Bool = false
    var giftMessage : String = ""
    
    var busLattitude : Double = 0.0
    var busLongitude : Double = 0.0

    @IBOutlet var dateAndTimeLabel: UILabel!
    
    @IBOutlet var googleMapContainer: UIView!
    
    @IBOutlet var mainAddress: UILabel!
    
    @IBOutlet var subAddress: UILabel!
    
    @IBOutlet var pickUpButtonOutlet: CheckBox!
   
    @IBOutlet var deleiveryButtonOutlet: CheckBox!
    
    @IBOutlet var asapButtonOutlet: CheckBox!
    
    @IBOutlet var scheduleDateTimeOutlet: CheckBox!
    
    @IBOutlet var paypalButtonOutlet: CheckBox!
    @IBOutlet var cashButtonOutlet: CheckBox!
    
    @IBOutlet var giftWrapButtonOutlet: CheckBox!
    
    @IBAction func scheduleButtonTapped(_ sender: Any) {
    }
    
    @IBAction func PlaceYourButtonTapped(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        
        
        let customerPlaceOrderData = CustDetailsPlaceOrderReqModel()
        let customerPlaceOrderUser :CustomerUserRequestModel = self.userDefaultManager.getCustomerCredential()
        let customerLangCode = CustomerLangCodeRequestModel()
        
        customerPlaceOrderData.deliveryAddress = deliveryAddress
        customerPlaceOrderData.deliveryLat = busLattitude
        customerPlaceOrderData.deliveryLong = busLongitude
        customerPlaceOrderData.deliveryMethod = deliveryMethod
        customerPlaceOrderData.deliverySchedule = deliverySchedule
        customerPlaceOrderData.productInfo = coreData.getCustomerItemInfo()
        customerPlaceOrderData.giftMessage = giftMessage
        customerPlaceOrderData.isGift = isGift
        customerPlaceOrderData.paymentMethod = paymentMethod
        
        let serviceFacadeUser = ServiceFacadeUser(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacadeUser.CustomerPlaceOrder(customerDataRequest: customerPlaceOrderData,
                                             customerUserRequest: customerPlaceOrderUser,
                                             customerLangCodeRequest: customerLangCode,
                                             completionHandler: {
                                                response in
                                                debugPrint(response)
                                                if(response?.errorCode == 0)
                                                {
                                                    
                                                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let vc: ConfirmPayViewController = storyboard.instantiateViewController(withIdentifier: "ConfirmPayViewController") as! ConfirmPayViewController
                                                    
                                                    vc.placeOrderResModel=response! as CustPlaceOrderResModel
                                                    
                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                   // self.present(vc, animated: true, completion: nil)
                                                    
                                                    
                                                }
                                                else{
                                                    self.showAlertMessage(title: "Alert", message:(response?.message)!)
                                                }

        
        })
        
        
    }
    
       
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleMapsView = GMSMapView(frame: self.googleMapContainer.frame)
        googleMapsView.delegate = self
        self.googleMapsView.settings.myLocationButton = true
        self.googleMapsView.isMyLocationEnabled = true
        self.view.addSubview(self.googleMapsView)
        
        pickUpButtonOutlet.checkedClickedDelegate = self
        deleiveryButtonOutlet.checkedClickedDelegate = self
        asapButtonOutlet.checkedClickedDelegate = self
        scheduleDateTimeOutlet.checkedClickedDelegate = self
        paypalButtonOutlet.checkedClickedDelegate = self
        cashButtonOutlet.checkedClickedDelegate = self
        giftWrapButtonOutlet.checkedClickedDelegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: nil)
        toolBar.setItems([doneButton], animated: false)
       
        
       
        
          }
    
    func cameraPositionOn(_ latitude : Double , longitude : Double){
        
        self.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14)
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - GMSMapViewrDelegate
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        
        
        let location: CLLocation =  CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.location = location
        self.getAddressFrom(coordinate: coordinate)
    }
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            var addresses:[GMSAddress]
            
            addresses = (response?.results())!
            print(addresses)
        
            self.mainAddress.text!=addresses[0].addressLine1()!
            self.subAddress.text!=addresses[0].addressLine2()!
            self.googleMapsView.clear()
                            let position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
                            let marker = GMSMarker(position: position)
                            marker.title = self.mainAddress.text!
                            marker.map = self.googleMapsView
                           self.googleMapsView.camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 14)
                }
    }
    
    func getAddressFrom(coordinate: CLLocationCoordinate2D ){
        self.reverseGeocodeCoordinate(coordinate: coordinate)
    }
    
    
    func placeAutocomplete(address: String!) {
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(address, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                    
                }
            }
        })
    }
    
    
    func addMarkerFromAddress(_ address : String){
        
        let geocoder: CLGeocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            if ((placemarks?.count)! > 0) {
                let pm: CLPlacemark = (placemarks?[0])!
                
                self.location = pm.location!
                self.getAddressFrom(coordinate: (pm.location?.coordinate)!)
                print(pm)
            }
        })
        
        self.placeAutocomplete(address: address)
        
        
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = locations.first
        
        let coordinate = location?.coordinate
        
        
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaceOrderGoogleMapSegue"
        {
            let navigationController = segue.destination as! UINavigationController
            let googleMapViewController = navigationController.viewControllers[0] as! GoogleMapViewController
            googleMapViewController.googlemapDelgate = self
            
            
        }
    }
    func getMapDetails(address: String, businessLat: Double, businessLon: Double) {
        busLattitude = businessLat
        busLongitude = businessLon
        deliveryAddress = address
        
        self.mainAddress.text! = address
        self.googleMapsView.clear()
        let position = CLLocationCoordinate2DMake(businessLat,businessLon)
        let marker = GMSMarker(position: position)
        marker.title = self.mainAddress.text!
        marker.map = self.googleMapsView
        self.googleMapsView.camera = GMSCameraPosition.camera(withLatitude:businessLat, longitude: businessLon, zoom: 14)
        
    }
    
    func onCheckedChange(buttonTag: Int, values: Bool) {
        switch buttonTag {
        case pickUpButtonOutlet.tag:
            if(values){
            deliveryMethod = DelieveryMethods.pickUp
            deleiveryButtonOutlet.isChecked = false
            }
            break
        case deleiveryButtonOutlet.tag:
            if(values){
            deliveryMethod = DelieveryMethods.homeDeleivery
            pickUpButtonOutlet.isChecked = false
            }
            break
        case asapButtonOutlet.tag:
            if(values){
                deliverySchedule = 0
                scheduleDateTimeOutlet.isChecked = false
                checkDeliverySchedule = true
            
            }
            break
        case scheduleDateTimeOutlet.tag:
            if(values){
                asapButtonOutlet.isChecked = false
                checkDeliverySchedule = true
                let alertView = UIAlertController.init(title: "Info", message: "select date and time", preferredStyle: .alert)
                let callActionHandler = { (action:UIAlertAction!) -> Void in
                    
                    
                }
                let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                let defaultAction2 = UIAlertAction.init(title:"Cancel", style: .destructive, handler: callActionHandler)
                alertView.addAction(defaultAction)
                alertView.addAction(defaultAction2)
                alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
               
                alertView.addTextField(configurationHandler: { (textField :UITextField) in
                    textField.addTarget(self, action: #selector(self.textFieldAction(sender:)), for:.editingDidBegin)
                    textField.placeholder = "Select date and time"
                    textField.borderStyle = UITextBorderStyle.roundedRect
                    
                    
        
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "dd MMM hh:mm a"
//                    textField.text = dateFormatter.string(from:self.datePicker.date)
//                    self.dateAndTimeLabel.text = textField.text
                    
                    textField.text = self.textString

                    
                    
                })
                self.present(alertView, animated: true)
                
                }
            break
        case paypalButtonOutlet.tag:
            if(values){
                paymentMethod = PaymentMethod.payPal
                cashButtonOutlet.isChecked = false
            }
            break
        case cashButtonOutlet.tag:
            if(values){
                paymentMethod = PaymentMethod.cash
                paypalButtonOutlet.isChecked = false
            }
            break
        case giftWrapButtonOutlet.tag:
            if(values){
                
                let alertView = UIAlertController.init(title: "Gift Message", message: "upto 180 characters", preferredStyle: .alert)
                let callActionHandler = { (action:UIAlertAction!) -> Void in
                    
                    self.giftWrapButtonOutlet.isChecked = false
                }
                let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                let defaultAction2 = UIAlertAction.init(title:"Cancel", style: .destructive, handler: callActionHandler)
                alertView.addAction(defaultAction)
                alertView.addAction(defaultAction2)
                alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                alertView.addTextField(configurationHandler: { (textField :UITextField) in
                    textField.placeholder = "Enter Message"
                    textField.borderStyle = UITextBorderStyle.roundedRect
                    self.giftMessage = textField.text!
                })
                isGift = true
                self.present(alertView, animated: true)
            }else{
            self.giftMessage = ""
                isGift = false
            }
            break
            

        default:
            //print("Nothing Clicked"); 
            break
        }
    }
    
    func validateData() -> Bool
    {
         if (mainAddress.text == "Select address")
        {
            self.showAlertMessage(title: "Info", message: "Please select delivery address")
            return false
        }
        else if (self.deliveryMethod == "")
        {
            self.showAlertMessage(title: "Info", message: "Please select delivery mode")
            return false
        }
        else if (self.paymentMethod == "")
        {
            self.showAlertMessage(title: "Info", message: "Please select payment mode")
            return false
        }
        else if (checkDeliverySchedule == false)
        {
            self.showAlertMessage(title: "Info", message: "Please select  delivery schedule")
            return false

        }
        
        return true
        
        
    }
    func handleTap(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM hh:mm a"
        
        self.textString = dateFormatter.string(from:sender.date)
        
    }
    func textFieldAction(sender : UITextField)
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleTap(sender:)), for: UIControlEvents.allEvents)
    
    }

   

    
    

    
}
