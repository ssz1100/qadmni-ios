//
//  SubmitFeedbackTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 11/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit
import Cosmos

class SubmitFeedbackTableViewCell: UITableViewCell {

    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var itemname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
