 //
//  AddProductViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 28/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController,
UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    let imagePickerController = UIImagePickerController()
    var categoryId : Int = 0
    var userDefaultManager : UserDefaultManager = UserDefaultManager()
    var imageURL : URL? = nil
    var productId : Int32 = 0
    var image : UIImage!
    var imageData: Data!

    
    let pickerView = UIPickerView()
    
    var categoryData : [VendorCategoryResponseModel] = []
    
    @IBOutlet var productDisplay: UIImageView!
    
    @IBAction func productPickerButton(_ sender: UIButton) {
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.present(imagePickerController,animated: true, completion:nil)
        
    }
    
    @IBOutlet var categoryPickerTxtField: UITextField!
    
    
    @IBOutlet var productNameEnglishTxt: UITextField!
    
    @IBOutlet var productNameArabicTxt: UITextField!
    
    @IBOutlet var productDetailEnglishTxt: UITextField!
    
    @IBOutlet var productDetailArabicTxt: UITextField!
    
    
    @IBOutlet var priceTxtField: UITextField!
    
    @IBOutlet var productOfferTxt: UITextField!
    
    @IBOutlet var switchOutlet: UISwitch!
    
    @IBAction func availableForSellSwitchAction(_ sender: UISwitch) {
    }
  
    @IBAction func addProductCancelButton(_ sender: UIButton) {
    }
    
    @IBAction func addProductSaveButton(_ sender: UIButton) {
        
        let vendorUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
        let vendorData = AddProductRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        vendorData.categoryId = categoryId
        vendorData.itemNameEn = self.productNameEnglishTxt.text!
        vendorData.itemNameAr = self.productNameArabicTxt.text!
        vendorData.itemDescEn = self.productDetailEnglishTxt.text!
        vendorData.itemDescAr = self.productDetailArabicTxt.text!
        vendorData.offerText = self.productOfferTxt.text!
        let price : String = self.priceTxtField.text!
        let priceDouble : Double = Double(price)!
        if (priceDouble == nil)
        {
            return
        }
        vendorData.price = priceDouble
        
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorAddProduct(vendorDataRequest: vendorData,
                                       vendorUserRequest: vendorUser,
                                       vendorLangCodeRequest: vendorLangCode,
                                       completionHandler: {
                                        response in
                                       self.productId = (response?.productId)!
                                        print(self.productId)
        
        })
       var addProductImageRequest = AddProductImageRequestModel()
        addProductImageRequest.productId = productId
        addProductImageRequest = self.userDefaultManager.getVendorImageDetail()
        serviceFacade.AddproductMultiPathData(filePathUrl: imageURL, addProductImage: addProductImageRequest)
        
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePickerController.delegate = self
        
        
        
        let vendorCategoryUser = VendorUserRequestModel()
        let vendorcategoryData = VendorCategoryRequestModel()
        let vendorLangCode = VendorLangCodeRequestmodel()
        
        
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.VendorCategory(vendorDataRequest: vendorcategoryData,
                                     vendorUserRequest: vendorCategoryUser,
                                     vendorLangCodeRequest: vendorLangCode,
                                     completionHandler: {
                                        response in
                                        self.pickerView.delegate = self
                                        self.pickerView.dataSource = self
                                        self.categoryData = response as! [VendorCategoryResponseModel]
                                        self.categoryPickerTxtField.inputView = self.pickerView
        
        
        })
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        imageURL = (info[UIImagePickerControllerReferenceURL] as! NSURL) as URL
        let imageName = imageURL?.absoluteString
        

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            productDisplay.image = pickedImage
            image = productDisplay.image!
            imageData = UIImageJPEGRepresentation(image!, 100)
           
            
        }
        
        dismiss(animated: true, completion: nil)
      
    }
   
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
       return categoryData.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryData[row].category
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.categoryPickerTxtField.text = categoryData[row].category
        categoryId = categoryData[row].categoryId
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    

    
}