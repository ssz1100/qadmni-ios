//
//  StatusGoogleMapViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 24/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class StatusGoogleMapViewController: UIViewController {
    
    var custLatitude : Double = 0
    var custLongitude : Double = 0
    var custName : String = ""
    var custAddress : String = ""
    @IBOutlet var googleMapContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: custLatitude, longitude: custLongitude, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: custLatitude, longitude: custLongitude)
        marker.title = custName
        marker.snippet = custAddress
        marker.map = mapView
    }
}
    

   

