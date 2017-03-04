//
//  PastOrderTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 04/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class PastOrderTableViewCell: UITableViewCell {

    @IBOutlet var feedbackButtonOutlet: UIButton!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var viewDetailsOutlet: UIButton!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusImageview: UIImageView!
    @IBOutlet var orderDateLabel: UILabel!
    @IBOutlet var orderIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
