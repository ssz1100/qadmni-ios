//
//  CheckBox.swift
//  Qadmni
//
//  Created by Prakash Sabale on 18/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    var checkedClickedDelegate : OnCheckClickedDelegate?

    let checkedImages = UIImage(named : "checked")! as UIImage
    let uncheckedImage = UIImage(named : "unchecked")! as UIImage
    
    var isChecked : Bool = false{
        didSet{
            if isChecked == true{
            self.setImage(checkedImages, for: .normal)
            
            }else{
            self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton)
    {
        if (sender == self){
            if (isChecked == true)
            {
            isChecked = false
            }else{
            isChecked = true
            }
            
            if (checkedClickedDelegate != nil)
            {
                checkedClickedDelegate?.onCheckedChange(buttonTag: self.tag, values: self.isChecked)
            }
            
        }
    
    }
}

public protocol OnCheckClickedDelegate
{
    func onCheckedChange(buttonTag : Int , values : Bool )
}
