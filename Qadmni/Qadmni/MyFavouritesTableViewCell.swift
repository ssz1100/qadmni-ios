//
//  MyFavouritesTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 31/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class MyFavouritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var subView: UIView!
    
    @IBOutlet var displayImageFav: UIImageView!
    
    @IBOutlet var productNamefav: UILabel!
    @IBOutlet var ratingbarFav: UIView!
    
    @IBOutlet var vendorName: UILabel!
    
    @IBOutlet var productDescription: UILabel!
    
    @IBOutlet var distanceLabel: UILabel!
    
    @IBOutlet var moneyLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var quantityStepper: UIStepper!
    
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var favImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
