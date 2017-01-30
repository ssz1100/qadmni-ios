//
//  VendorOrderStatusTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 30/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class VendorOrderStatusTableViewCell: UITableViewCell {
    
    @IBOutlet var orderIdLabel: UILabel!
    
    @IBOutlet var orderDateLabel: UILabel!
    @IBOutlet var paymentModeLabel: UILabel!
    
    @IBOutlet var deleiveryTypeLabel: UILabel!
    
    @IBOutlet var customerNameLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
