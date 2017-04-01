//
//  LiveOrderTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 04/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class LiveOrderTableViewCell: UITableViewCell {

    @IBOutlet var subView: UIView!
    @IBOutlet var feedbackButtonOutlet: UIButton!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var trackOrderButtonOutlet: UIButton!
    @IBOutlet var orderStatuslabel: UILabel!
    @IBOutlet var statusImageview: UIImageView!
    @IBOutlet var deliveryLabel: UILabel!
    @IBOutlet var paymentModeLabel: UILabel!
    @IBOutlet var orderDatelabel: UILabel!
    @IBOutlet var orderIdLabel: UILabel!
    @IBOutlet var producerNameLabel: UILabel!
    @IBOutlet var orderStatusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
