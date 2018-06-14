//
//  TDCell.swift
//  ToDoozy
//
//  Created by Stephanie Fischer on 5/29/18.
//  Copyright © 2018 SUMA_. All rights reserved.
//

import UIKit

class TDCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
