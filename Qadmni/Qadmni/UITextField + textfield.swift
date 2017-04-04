//
//  UITextField + textfield.swift
//  Qadmni
//
//  Created by Prakash Sabale on 18/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UITextField
{
    func underlined(){
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    ///  Add a image icon on the left side of the textfield
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        
        
        imgView.frame = CGRect(x: frame.width - 10 - imageSize.width, y: (frame.height - imageSize.height) / 2 , width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    
    
    ///  Add a image icon on the Right side of the textfield
    public func addRightIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let rightView = UIView()
        rightView.frame = frame
        let imgView = UIImageView()
        
        
        imgView.frame = CGRect(x: frame.width - 15 - imageSize.width, y: (frame.height - imageSize.height) / 2 , width: imageSize.width, height: imageSize.height)
        imgView.image = image
        rightView.addSubview(imgView)
        self.rightView = rightView
        self.rightViewMode = UITextFieldViewMode.always
    }



}

extension UIButton
{
    public func roundedButton()
    {
        
    self.layer.cornerRadius = 10
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.white.cgColor
    }
    
    public func roundedBlackColorBorderButton()
    {
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

}

extension UILabel
{
    func underlined(){
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}

extension UIView
{
    func roundedView()
    {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    
    }
    
    func roundedGreyBorder()
    {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    }
extension UIImageView
{
    func roundedImageView()
    {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }

}



    


extension UIViewController
{
    
    func showAlertMessage(title: String, message : String)
    {
        let alertView = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            print("showAlert")
        }
        let defaultAction = UIAlertAction.init(title: NSLocalizedString("okLabel", comment: ""), style: .default, handler: callActionHandler)
        alertView.addAction(defaultAction)
        alertView.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(alertView, animated: true)
        
        
    }
    
    
    func showActivity()
    {
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideActivity()
    {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
}



