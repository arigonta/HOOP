//
//  DetailActivityViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 23/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class DetailActivityViewController: UIViewController {

    var minutes = 0
    var seconds = 5
    var timer = Timer()
    var activities:String = ""
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var startBtnOutlet: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    
    @IBAction func startBtn(_ sender: UIButton) {
        if(seconds != 0 ){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        
    }
    
    func buttonHide(){
        startBtnOutlet.isHidden = true
        doneBtnOutlet.isHidden = true
        timerLbl.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLbl.text = "0\(minutes) : 0\(seconds)"
        if activities == "Breathing"{
            //showImg.loadGif(name: "")
            titleLbl.text = activities
            descLbl.text = "Take a time to breath"
        }else if activities == "Jogging"{
            showImg.loadGif(name: "Jogging")
            titleLbl.text = activities
            descLbl.text = "Lets start jogging for 10 - 15 minutes, A little move for your body can be a good health for your mind"
            buttonHide()
        }else if activities == "Meditate"{
            showImg.loadGif(name: "Meditation")
            titleLbl.text = activities
            descLbl.text = "Take a time for 5 - 10 minutes to calm your mind"
            buttonHide()
        }else if activities == "Healthy Food"{
            showImg.loadGif(name: "Healthy Food")
            titleLbl.text = activities
            descLbl.text = "Eat some healthy food"
            buttonHide()
        }else if activities == "Healthy Sleep"{
            showImg.loadGif(name: "Healthy Sleep")
            titleLbl.text = activities
            descLbl.text = "Take a little rest. It will help you to be more fresh"
            buttonHide()
        }
    }
    
    @objc func action(){
        seconds -= 1
        timerLbl.text = "0\(minutes) : 0\(seconds)"
        
        if seconds == 0{
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
