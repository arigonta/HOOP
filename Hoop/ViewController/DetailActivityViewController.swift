//
//  DetailActivityViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 23/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

class DetailActivityViewController: UIViewController {

    var minutes = 0
    var seconds = 0
    var timer = Timer()
    var activities:String = ""
    var heartCondition:String?
    var afterHeartCondition:String?
    var detectedBpm: Int?
    var heartRateQuery:HKQuery?
    var observerQuery:HKQuery?
    var startTime = ""
    

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var startBtnOutlet: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    @IBOutlet weak var resetBtnOutlet: UIButton!
    
    @IBAction func resetBtn(_ sender: UIButton) {
        if activities == "Breathing"{
            seconds = 5
        }else if activities == "Jogging"{
            minutes = 15
        }else if activities == "Meditation"{
            minutes = 10
        }
        startBtnOutlet.isHidden = false
        doneBtnOutlet.isHidden = true
    }
    
    @IBAction func startBtn(_ sender: UIButton) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
            startBtnOutlet.isHidden = true
            resetBtnOutlet.isHidden = true
        let now = Date()
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        startTime = timeFormat.string(from: now)
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        do {
            let now = Date()
            let newActive = NSEntityDescription.insertNewObject(forEntityName: "History", into: context)
            let dateFormat = DateFormatter()
            let timeFormat = DateFormatter()
            dateFormat.dateFormat = "dd MMM yyyy"
            timeFormat.dateFormat = "HH:mm"
            newActive.setValue(activities, forKey: "activityName")
            newActive.setValue(dateFormat.string(from: now), forKey: "activityDate")
            newActive.setValue(afterHeartCondition, forKey: "afterHeartCondition")
            newActive.setValue(timeFormat.string(from: now), forKey: "endTime")
            newActive.setValue(heartCondition, forKey: "beforeHeartCondition")
            newActive.setValue(startTime, forKey: "startTime")
            try context.save()
        } catch  {
            
        }
        performSegue(withIdentifier: "goToHomeView", sender: self)
    }
    
    func buttonHide(){
        startBtnOutlet.isHidden = true
        doneBtnOutlet.isHidden = true
        resetBtnOutlet.isHidden = true
        timerLbl.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observerHeartRateSamples()
        doneBtnOutlet.isHidden = true
        resetBtnOutlet.isHidden = true
        if activities == "Breathing"{
            showImg.loadGif(name: "Breath")
            titleLbl.text = activities
            descLbl.text = "Take a time to breath"
            seconds = 5
        }else if activities == "Jogging"{
            showImg.loadGif(name: "Jogging")
            titleLbl.text = activities
            descLbl.text = "Lets start jogging for 10 - 15 minutes, A little move for your body can be a good health for your mind"
            minutes = 15
        }else if activities == "Meditate"{
            showImg.loadGif(name: "Meditation")
            titleLbl.text = activities
            descLbl.text = "Take a time for 5 - 10 minutes to calm your mind"
            minutes = 10
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
        
        if seconds == 1 && minutes == 0{
            doneBtnOutlet.isHidden = false
            resetBtnOutlet.isHidden = false
            seconds -= 1
            timerLbl.text = "\(String(format: "%02d", minutes)) : \(String(format: "%02d", seconds))"
            timer.invalidate()
        }else if (seconds == 1){
            seconds = 59
            minutes -= 1
        }else if (seconds == 0 && minutes > 0){
            seconds = 59
            minutes -= 1
        }else{
            seconds -= 1
        }
        timerLbl.text = "\(String(format: "%02d", minutes)) : \(String(format: "%02d", seconds))"
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
    
    func observerHeartRateSamples() {
        let heartRateSampleType = HKObjectType.quantityType(forIdentifier: .heartRate)
        
        if let observerQuery = observerQuery {
            health.stop(observerQuery)
        }
        
        self.observerQuery = HKObserverQuery(sampleType: heartRateSampleType!, predicate: nil) { (_, _, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            fetchLatestHeartRateSample { (sample) in
                guard let sample = sample else {
                    return
                }
                let heartRateUnit = HKUnit(from: "count/min")
                let heartRate = sample
                    .quantity
                    .doubleValue(for: heartRateUnit)
                if Int(heartRate) >= 40 && Int(heartRate) < 150{
                    self.afterHeartCondition = "green"
                }else if Int(heartRate) >= 150 && Int(heartRate) < 180{
                    self.afterHeartCondition = "yellow"
                }else if Int(heartRate) >= 180{
                    self.afterHeartCondition = "red"
                }
                
            }
        }
        health.execute(observerQuery!)
    }
}
