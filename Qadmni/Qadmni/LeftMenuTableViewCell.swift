//
//  LeftMenuTableViewCell.swift
//  Qadmni
//
//  Created by Prakash Sabale on 23/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
