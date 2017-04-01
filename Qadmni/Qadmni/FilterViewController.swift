//
//  FilterViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 28/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var selectedSort : Int = 0
    var priceFilter : Double = 0
    var distanceFilter : Double = 0
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var sortType = SortByConstant()
    @IBOutlet var priceLabelOutlet: UILabel!
    @IBOutlet var distanceLabelOutlet: UILabel!
    @IBOutlet var distancefilterOutlet: UISlider!
    @IBOutlet var priceFilterOutlet: UISlider!
    @IBOutlet var reviewButtonOutlet: UIButton!
    @IBOutlet var priceButtonOutlet: UIButton!
    @IBOutlet var distanceButtonOutlet: UIButton!
    @IBAction func distanceButton(_ sender: UIButton) {
        self.selectedSort = sortType.distanceSort
        self.setDistanceUi()
    
    }
    
    @IBAction func priceButton(_ sender: UIButton) {
        self.selectedSort = sortType.priceSort
        self.setPriceUi()
    }
    
    @IBAction func reviewsButton(_ sender: UIButton) {
      self.selectedSort = sortType.reviewSort
       self.setReviewsUi()
    }
    
    @IBAction func distanceSegment(_ sender: UISlider) {
        self.distanceFilter = Double(self.distancefilterOutlet.value)
        self.distanceLabelOutlet.text = String(distancefilterOutlet.value)
    }
    
    @IBAction func priceSlider(_ sender: UISlider) {
        self.priceFilter = Double(self.priceFilterOutlet.value)
        self.priceLabelOutlet.text = String(priceFilterOutlet.value)
    }
    
    @IBAction func applyButtonTabbed(_ sender: UIButton) {
    self.userDefaultManager.setSelectedSortBy(selectedSort: selectedSort)
        self.userDefaultManager.setFiltertedByPrice(filterByPrice: self.priceFilter)
        self.userDefaultManager.setFiltertedByDistance(filterByDistance: self.distanceFilter)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func filterBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        userDefaultManager.setFiltertedByDistance(filterByDistance: 0)
        userDefaultManager.setFiltertedByPrice(filterByPrice: 0)
        self.userDefaultManager.setSelectedSortBy(selectedSort:sortType.noSort)
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceFilterOutlet.maximumValue = 10000
        priceFilterOutlet.minimumValue = 10
        distancefilterOutlet.maximumValue = 100
        distancefilterOutlet.minimumValue = 1
        
        priceFilter=userDefaultManager.getFiltertedByPrice()
        priceFilterOutlet.value=Float(priceFilter)
        
        distanceFilter = userDefaultManager.getFiltertedByDistance()
        distancefilterOutlet.value = Float(distanceFilter)
        self.distanceLabelOutlet.text = String(distancefilterOutlet.value)
        self.priceLabelOutlet.text = String(priceFilterOutlet.value)
        
        
        selectedSort = userDefaultManager.getSelectedSortBy()
        if(selectedSort == sortType.distanceSort)
        {
            self.setDistanceUi()
        }else if (selectedSort == sortType.priceSort)
        {
            self.setPriceUi()
        }
        else if (selectedSort == sortType.reviewSort)
        {
        self.setReviewsUi()
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setDistanceUi()
    {
        let origImage = UIImage(named: "location");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        distanceButtonOutlet.setImage(tintedImage, for: .normal)
        distanceButtonOutlet.tintColor = UIColor.brown
        priceButtonOutlet.tintColor = UIColor.black
        reviewButtonOutlet.tintColor = UIColor.black

    }
    func setPriceUi()
    {
        let origImage = UIImage(named: "cash_black");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        priceButtonOutlet.setImage(tintedImage, for: .normal)
        priceButtonOutlet.tintColor = UIColor.brown
        distanceButtonOutlet.tintColor = UIColor.black
        reviewButtonOutlet.tintColor = UIColor.black
    }
    
    func setReviewsUi()
    {
        let origImage = UIImage(named: "review_black");
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        reviewButtonOutlet.setImage(tintedImage, for: .normal)
        reviewButtonOutlet.tintColor = UIColor.brown
        priceButtonOutlet.tintColor = UIColor.black
        distanceButtonOutlet.tintColor = UIColor.black

    }
}
