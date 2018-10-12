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
    @IBOutlet weak var imgHeart: UIImageView!
    
    func setHistory(his: History) {
        if his.afterHeartCondition == "green"{
            imgHeart.loadGif(name: "GreenHeart")
        }else if his.afterHeartCondition == "yellow"{
            imgHeart.loadGif(name: "YellowHeart")
        }else if his.afterHeartCondition == "red"{
            imgHeart.loadGif(name: "RedHeart")
        }
    }
}
