//
//  UserCartTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class UserCartTableViewCell: UITableViewCell {
    
    @IBOutlet var quantitylabel: UILabel!
   
    @IBOutlet var productLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
