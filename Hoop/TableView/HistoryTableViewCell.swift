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
    @IBOutlet weak var HistoryImg: UIImageView!
    @IBOutlet weak var HistoryLblDate: UILabel!
    @IBOutlet weak var imgHeart: UIImageView!
    
    func setHistory(his: History) {
//        HistoryLbl.text = his.activityDate
        HistoryLbl.text = his.activityName
        HistoryLblDate.text = his.activityDate
        if his.heartCondition == "green"
        {
            imgHeart.loadGif(name: "GreenHeart")
        }else if heartImage == "yellow"{
            imgHeart.loadGif(name: "YellowHearth")
        }else if heartImage == "red"{
            imgHeart.loadGif(name: "RedHeart")
        }
    }
}
