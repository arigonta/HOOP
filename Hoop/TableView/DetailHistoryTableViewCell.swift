//
//  DetailHistoryTableViewCell.swift
//  Hoop
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 11/10/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class DetailHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
