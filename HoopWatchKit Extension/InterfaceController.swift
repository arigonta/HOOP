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
    
    let healthStore = HKHealthStore()
    
    @IBOutlet var startLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        guard HKHealthStore.isHealthDataAvailable() == true else {
            startLabel.setText("Not available")
            return
        }
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
            displayNotAllowed()
            return
        }
        let dataTypes = Set(arrayLiteral: quantityType)
        healthStore.requestAuthorization(toShare: nil, read: dataTypes) { (success, error) -> Void in
            if success == false {
                self.displayNotAllowed()
            }
        }
        super.willActivate()
    }
    
    func displayNotAllowed() {
        startLabel.setText("not allowed")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    
}

