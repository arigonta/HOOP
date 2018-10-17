//
//  SectionTableViewCell.swift
//  Hoop
//
//  Created by Ari Gonta on 10/15/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    @IBOutlet weak var headerText: UILabel!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
