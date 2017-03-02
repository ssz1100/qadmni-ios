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
    var isImagePicked : Bool = false

    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProductSaveButton(_ sender: UIButton) {
        
        let checkOut : Bool = validateData()
        
        if(!checkOut)
        {
            return;
        }
        if (productId > 0)
        {
            let vendorUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
            let vendorData = VendorUpdateProductReqModel()
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
            serviceFacade.vendorUpdateProduct(vendorDataRequest: vendorData,
                                              vendorUserRequest: vendorUser,
                                              vendorLangCodeRequest: vendorLangCode,
                                              completionHandler: {
                                                response in
                                                if (self.isImagePicked)
                                                {
                                                    self.addMulipartImage(productId: self.productId)
                                                    if (response?.errorCode == 0)
                                                    {
                                                        let alertView = UIAlertController.init(title:"Update product" , message:"Product updated successfully", preferredStyle: .alert)
                                                        let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                            
                                                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as UIViewController
                                                            self.present(vc, animated: true, completion: nil)
                                                            
                                                            
                                                        }
                                                        let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: callActionHandler)
                                                        alertView.addAction(defaultAction)
                                                        alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                                        self.present(alertView, animated: true)

                                                    }
                                                    else{
                                                        self.showAlertMessage(title: "Update product", message: (response?.message)!)
                                                    }
                                                                                                    }
            })
        
        
        }else{
        
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
//                                       self.productId = (response?.productId)!
//                                        print(self.productId)
                                        self.addMulipartImage(productId: (response?.productId)!)
                                        if (response?.errorCode == 0)
                                        {
                                            let alertView = UIAlertController.init(title:"Add product" , message:"Product added successfully", preferredStyle: .alert)
                                            let callActionHandler = { (action:UIAlertAction!) -> Void in
                                                
                                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as UIViewController
                                                self.present(vc, animated: true, completion: nil)
                                                
                                            }
                                            let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: callActionHandler)
                                            alertView.addAction(defaultAction)
                                            alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                            self.present(alertView, animated: true)
                                        }else{
                                        self.showAlertMessage(title: "Add product" , message: (response?.message)!)
                                        }
                                        


        })
        }
        
        

    }
    
    private func addMulipartImage(productId : Int32)
    {
        var addProductImageRequest = AddProductImageRequestModel()
        addProductImageRequest = self.userDefaultManager.getVendorImageDetail()
        addProductImageRequest.productId = productId
        let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
        serviceFacade.AddproductMultiPathData(fileData: imageData, addProductImage: addProductImageRequest)
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
        
        if (productId > 0)
        {
            let vendorItemDetailUser : VendorUserRequestModel = self.userDefaultManager.getVendorDetail()
            let vendorItemDetailData = VendorItemDetailReqModel()
            vendorItemDetailData.productId = productId
            let vendorLangCode = VendorLangCodeRequestmodel()
            
            
            let serviceFacade = ServiceFacade(configUrl : PropertyReaderFile.getBaseUrl())
            serviceFacade.vendorItemDetail(vendorDataRequest: vendorItemDetailData,
                                           vendorUserRequest: vendorItemDetailUser,
                                           vendorLangCodeRequest: vendorLangCode,
                                           completionHandler: {
                                            response in
                                            self.productNameEnglishTxt.text = response?.itemNameEn
                                            self.productNameArabicTxt.text = response?.itemNameAr
                                            self.productDetailEnglishTxt.text = response?.itemDescEn
                                            self.productDetailArabicTxt.text = response?.itemDescAr
                                            self.productNameArabicTxt.text = response?.itemNameAr
                                            self.productOfferTxt.text = response?.offerText
                                            let price : Double = (response?.unitPrice)!
                                            self.priceTxtField.text = String(price)
                                            self.categoryPickerTxtField.text = self.getCategoryName(categoryId: (response?.categoryId)!)
                                            
                                            if(response?.isActive == 1)
                                            {
                                            self.switchOutlet.isOn = true
                                            }
                                            else{
                                            self.switchOutlet.isOn = false
                                            }
                                            
                                            let url = URL(string:(response?.imageUrl)!)
                                            if(url == nil){}
                                            else
                                            {
                                                let data = NSData(contentsOf:url!)
                                                self.productDisplay.image = UIImage(data:data as! Data)
                                            }

            })
        
        
        
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        imageURL = (info[UIImagePickerControllerReferenceURL] as! NSURL) as URL
            let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            productDisplay.image = pickedImage
            isImagePicked = true
            image = productDisplay.image!
            imageData = UIImageJPEGRepresentation(image!, 100)
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
    
    func getCategoryName(categoryId : Int) -> String
    {   var categoryname : String = ""
        for category in categoryData
        {
            if (category.categoryId == categoryId)
            {
            categoryname = category.category
            }
            
        }
        return categoryname
    
    }
    
    func validateData() -> Bool
    {
        
        if (self.categoryPickerTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please select category")
            return false
        }
        else if (self.productNameEnglishTxt.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter product name in english")
            return false
        }
        else if (self.productNameArabicTxt.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter product name in arabic")
            return false
        }
        else if (self.productDetailEnglishTxt.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter product description in english")
            return false
        }
        else if (self.productDetailArabicTxt.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter product description in arabic")
            return false
        }
        else if (self.priceTxtField.text?.isEmpty)!
        {
            self.showAlertMessage(title: "Info", message: "Please enter price")
            return false
        }
        else if (!self.isImagePicked)
        {
            self.showAlertMessage(title: "Info", message: "Please select product image")
            return false
        }

        return true
        
        
    }
    
    



    
}
