//
//  ProcessItemTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 20/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class ProcessItemTableViewCell: UITableViewCell {
    @IBOutlet var itemQuantity: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
