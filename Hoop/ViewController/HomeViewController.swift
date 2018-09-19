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

class HomeViewController: UIViewController {
    
    var heartImage:String = ""
    var userName:String = ""
    var heartRateQuery:HKQuery?
    var observerQuery:HKQuery?
    let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    let health: HKHealthStore = HKHealthStore()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var hrvLabel: UILabel!
    @IBOutlet weak var heartImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromModel()
        observerHeartRateSamples()
        nameLabel.text = "Hi, \(userName)"
        self.fetchLatestHeartRateSample(completion: { sample in
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
                
                if Int(heartRate) >= 20 && Int(heartRate) < 150{
                    self.heartImg.loadGif(name: "GreenHeart")
                    self.heartImage = "green"
                    self.hrvLabel.text = "Today, you seem very happy. Here some activity that can make you feel better than ever"
                }else if Int(heartRate) >= 150 && Int(heartRate) < 180{
                    self.heartImg.loadGif(name: "YellowHeart")
                    self.heartImage = "yellow"
                    self.hrvLabel.text = "Youre Yellow! get some help!"
                }else if Int(heartRate) >= 180{
                    self.heartImg.loadGif(name: "RedHeart")
                    self.heartImage = "red"
                    self.hrvLabel.text = "Youre Red! get some help!"
                }
            }
        })
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
            print("Gagal ngambil data!")
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
            
            self.fetchLatestHeartRateSample { (sample) in
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
                    
                    if Int(heartRate) >= 100 && Int(heartRate) < 150{
                        self.heartImg.loadGif(name: "GreenHeart")
                        self.heartImage = "green"
                    }else if Int(heartRate) >= 150 && Int(heartRate) < 180{
                        self.heartImg.loadGif(name: "YellowHeart")
                        self.heartImage = "yellow"
                    }else if Int(heartRate) >= 6969 && Int(heartRate) < 14045{
                        self.heartImg.loadGif(name: "RedHeart")
                        self.heartImage = "red"
                    }
                }
            }
        }
        health.execute(observerQuery!)
    }
    
    func fetchLatestHeartRateSample(
        completion: @escaping (_ sample: HKQuantitySample?) -> Void) {
        
        /// Create sample type for the heart rate
        guard let sampleType = HKObjectType
            .quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
        }
        
        /// Predicate for specifiying start and end dates for the query
        let predicate = HKQuery
            .predicateForSamples(
                withStart: Date.distantPast,
                end: Date(),
                options: .strictEndDate)
        
        /// Set sorting by date.
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false)
        
        /// Create the query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) { (_, results, error) in
                
                guard error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                
                completion(results?[0] as? HKQuantitySample)
        }
        
        self.health.execute(query)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func activityButton(_ sender: Any) {
        performSegue(withIdentifier: "toActivityRecom", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toActivityRecom" {
            let destVC = segue.destination as! ActivityRecViewController
            destVC.heartImage = heartImage
        }
        else if let destination = segue.destination as? HistoryViewController{
            destination.heartImage = heartImage
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
