//
//  OrderDetailsTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 09/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    @IBOutlet var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
