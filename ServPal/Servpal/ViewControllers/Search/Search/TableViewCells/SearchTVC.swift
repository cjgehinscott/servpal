//
//  SearchTVC.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/23/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialsLabel.clipsToBounds = true
        initialsLabel.layer.cornerRadius = (initialsLabel.frame.size.width / 2.0)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
