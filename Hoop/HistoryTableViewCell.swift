//
//  HistoryTableViewCell.swift
//  Hoop
//
//  Created by Ari Gonta on 8/21/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var HistoryLbl: UILabel!
    
    func setHistory(his: History) {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
        dateFormater.dateStyle = .none
        HistoryLbl.text = dateFormater.string(from: his.activityDate!)
    }
}
