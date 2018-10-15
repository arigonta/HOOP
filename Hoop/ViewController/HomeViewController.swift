//
//  HomeViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import HealthKit
import CoreData
import WatchConnectivity
import UserNotifications

class HomeViewController: UIViewController {
    
    var bpmText: Int = 0
    var heartImage:String = ""
    var userName:String = ""
    var observerQuery:HKQuery?
    let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    let health: HKHealthStore = HKHealthStore()
    var wcSession: WCSession?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var hrvLabel: UILabel!
    @IBOutlet weak var heartImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wcSession = WCSession.default
        wcSession?.delegate = self
        wcSession?.activate()
        fetchDataFromModel()
        observerHeartRateSamples()
        checkBpm()
        nameLabel.text = "Hi, \(userName)"
    }
    
    func fetchDataFromModel() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let  result = try context.fetch(request)
            if result.count > 0
            {
                for result in result as! [NSManagedObject]
                {
                    if let name = result.value(forKey: "name") as? String
                    {
                        userName = name
                    }
                    
                }
            }
        } catch  {
            print("Gagal mengambil data!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                
                DispatchQueue.main.async {
                    
                    /// Converting the heart rate to bpm
                    let heartRateUnit = HKUnit(from: "count/min")
                    let heartRate = sample
                        .quantity
                        .doubleValue(for: heartRateUnit)
                    /// Updating the UI with the retrieved value
                    self.bpmLabel.text = "\(Int(heartRate)) BPM"
                    UserDefaults.standard.set(Int(heartRate), forKey: "notif")
                    
                    if Int(heartRate) >= 50 && Int(heartRate) < 150{
                        self.heartImg.loadGif(name: "GreenHeart")
                        self.heartImage = "green"
                        self.hrvLabel.text = "Today, you seem very happy. Here some activity that can make you feel better than ever"
                    }else if Int(heartRate) >= 150 && Int(heartRate) < 180{
                        self.heartImg.loadGif(name: "YellowHeart")
                        self.heartImage = "yellow"
                    }else if Int(heartRate) >= 180{
                        self.heartImg.loadGif(name: "RedHeart")
                        self.heartImage = "red"
                    }
                }
            }
        }
        health.execute(observerQuery!)
    }
    
    
    
    @IBAction func activityButton(_ sender: Any) {
        performSegue(withIdentifier: "toActivityRecom", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toActivityRecom" {
            let destVC = segue.destination as! ActivityRecViewController
            destVC.heartImage = heartImage
        }
        else if segue.identifier == "toHistory"{
            let destVC = segue.destination as! HistoryViewController
            destVC.heartImage = heartImage
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func checkBpm() {
        DispatchQueue.main.async {
            self.bpmLabel.text = String(self.bpmText) + " BPM"
            if self.bpmText == 0 {
                self.bpmLabel.text = "Reading..."
            }
            if self.bpmText >= 50 && self.bpmText < 150{
                self.heartImg.loadGif(name: "GreenHeart")
                self.heartImage = "green"
                self.hrvLabel.text = "Today, you seem very happy. Here some activity that can make you feel better than ever"
            }else if self.bpmText >= 150 && self.bpmText < 180{
                self.heartImg.loadGif(name: "YellowHeart")
                self.heartImage = "yellow"
                self.hrvLabel.text = "You are Yellow! get some help!"
            }else if self.bpmText >= 180{
                self.heartImg.loadGif(name: "RedHeart")
                self.heartImage = "red"
                self.hrvLabel.text = "You are Red! get some help!"
            }
        }
    }
}

extension HomeViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("\(#function) \(session)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function) \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("\(#function) \(session)")
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let context = applicationContext["bpm"] as? Int {
            self.bpmText = context
            checkBpm()
            print(context)
        }
        
    }
}
