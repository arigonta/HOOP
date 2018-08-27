//
//  StartViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 15/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

class StartViewController: UIViewController {
    
    let healthKitStore = HKHealthStore()
    
    @IBAction func startBtn(_ sender: Any) {
        performSegue(withIdentifier: "startToHome", sender: self)
    }
    override func viewDidLoad() {
        //        saveMockHeartData()
        //        let appDel = UIApplication.shared.delegate as! AppDelegate
        //        let context = appDel.persistentContainer.viewContext
        //        do {
        //            let today = Date()
        //            let newHis = NSEntityDescription.insertNewObject(forEntityName: "History", into: context)
        //            let dateFormat = DateFormatter()
        //            dateFormat.dateFormat = "dd/MM/yy HH:mm"
        //            newHis.setValue("Breathing", forKey: "activityName")
        //            newHis.setValue(dateFormat.string(from: today), forKey: "activityDate")
        //            newHis.setValue("Green", forKey: "heartCondition")
        //            try context.save()
        //        } catch {
        //        }
        super.viewDidLoad()
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //
        //        let context = appDelegate.persistentContainer.viewContext
        //
        //        super.viewDidLoad()
        //        // baca core data
        //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        //
        //        request.returnsObjectsAsFaults = false
        //
        //        do {
        //            let  result = try context.fetch(request)
        //            if result.count > 0
        //            {
        //                for result in result as! [NSManagedObject]
        //                {
        //                    if let name = result.value(forKey: "activityDate") as? String
        //                    {
        //                        print(name)
        //                    }
        //                    if let age = result.value(forKey: "activityName") as? String
        //                    {
        //                        print(age)
        //                    }
        ////                                                context.delete(result)
        //                }
        ////                                        try context.save()
        //            }
        //        } catch  {
        //            print("Gagal ngambil data!")
        //        }
        // baca core data
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func saveMockHeartData() {
//        
//        // 1. Create a heart rate BPM Sample
//        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
//        let heartRateQuantity = HKQuantity(unit: HKUnit(from: "count/min"),
//                                           doubleValue: Double(arc4random_uniform(80) + 100))
//        let nowDate = Date()
//        let heartSample = HKQuantitySample(type: heartRateType, quantity: heartRateQuantity, start: nowDate, end: nowDate)
//        
//        // 2. Save the sample in the store
//        healthKitStore.save(heartSample, withCompletion: { (success, error) -> Void in
//            if let error = error {
//                print("Error saving heart sample: \(error.localizedDescription)")
//            }
//        })
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

