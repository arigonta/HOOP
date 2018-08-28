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
    
    var userName:String = ""
    var heartRateQuery:HKQuery?
    let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    let health: HKHealthStore = HKHealthStore()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var hrvLabel: UILabel!
    @IBOutlet weak var heartImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromModel()
        
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
                if Int(heartRate) >= 100 && Int(heartRate) < 150{
                    self.heartImg.loadGif(name: "GreenHeart")
                }else if Int(heartRate) >= 150 && Int(heartRate) < 180{
                    self.heartImg.loadGif(name: "YellowHeart")
                }else if Int(heartRate) >= 6969 && Int(heartRate) < 14045{
                    self.heartImg.loadGif(name: "RedHeart")
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

}
