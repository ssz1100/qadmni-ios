//
//  GoogleMapViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 03/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: UIViewController,UISearchBarDelegate,LocateOnTheMap,GMSAutocompleteFetcherDelegate {
    
    @IBAction func backBarButtonAction(_ sender: Any) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "VendorShopDetailViewController") as UIViewController
//        self.present(vc, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    var businessLat :Double = 0.0
    var businessLong :Double = 0.0
    var businessAddress : String = ""
    
    var googlemapDelgate:GoogleMapDelegate?
    
   
    
    
    @IBAction func selectAddressLocation(_ sender: UIButton) {
        
        if (businessLat == 0.0 || businessLong == 0.0)
        {
        self.showAlertMessage(title: NSLocalizedString("alertLabel", comment: ""), message: NSLocalizedString("shopDetails.buisnessLocation", comment: ""))
        
        }
        else
        {
            googlemapDelgate?.getMapDetails(address: businessAddress, businessLat: businessLat, businessLon: businessLong)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }

    
    @IBOutlet var googleMapsContainer: UIView!
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!

    @IBAction func searchWithAddress(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        self.present(searchController, animated:true, completion: nil)
        
    }
   
    
        override func viewDidLoad()
        {
           super.viewDidLoad()
                }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
        
    }
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        businessLat = lat
        businessLong = lon
        businessAddress = title
        print(businessAddress)
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
        
            
        }
        
    }
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                let placeClient = GMSPlacesClient()
        
        
                placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
                   // NSError myerr = Error;
                   // print("Error @%",Error.self)
        
                    self.resultsArray.removeAll()
                    if results == nil {
                        return
                    }
        
                    for result in results! {
                        if let result = result as? GMSAutocompletePrediction {
                            self.resultsArray.append(result.attributedFullText.string)
                        }
                    }
        
                    self.searchResultController.reloadDataWithArray(self.resultsArray)
        
                }
        
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
       }
public protocol GoogleMapDelegate {
    func getMapDetails(address:String,businessLat:Double,businessLon:Double)
    
    
}


