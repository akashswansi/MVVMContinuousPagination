//
//  CustomTableViewCell.swift
//  MVVMContinuousPagination
//
//  Created by Kumar, Akash on 6/29/20.
//  Copyright © 2020 Kumar, Akash. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var imageProfileView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
