//
//  InterfaceController.swift
//  HoopWatchKit Extension
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 28/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import HealthKit


class InterfaceController: WKInterfaceController {

    @IBOutlet var bpmLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        var heartRateQuery:HKQuery?
        let heartRateType:HKQuantityType   = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let health: HKHealthStore = HKHealthStore()
        
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
            }
        })
        
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
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    
}

