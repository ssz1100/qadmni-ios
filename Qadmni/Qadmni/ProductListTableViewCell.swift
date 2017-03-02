//
//  ProductListTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 30/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet var productAvailableLabel: UILabel!
    @IBOutlet var displayProductImage: UIImageView!
    
    @IBOutlet var displayProductName: UILabel!
    
    @IBOutlet var categoryTypeLabel: UILabel!
    
    @IBOutlet var detailProductLabel: UILabel!
    
    @IBOutlet var productPrice: UILabel!
    
    @IBOutlet var updateProductOutlet: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
