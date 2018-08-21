//
//  HealthKitHandler.swift
//  Hoop
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 21/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()

public class Alert {
    class func ShowAlert(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

public func authorizeHealthKit() {
            if HKHealthStore.isHealthDataAvailable() {
                let infoToRead = Set([
                    HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
                    HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
                    HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                    HKSampleType.quantityType(forIdentifier: .heartRate)!
                    ])
                let infoToWrite = Set([
                    HKSampleType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                    HKSampleType.quantityType(forIdentifier: .heartRate)!
                    ])
                
                healthKitStore.requestAuthorization(toShare: infoToWrite, read: infoToRead) { (success, error) -> Void in
                    print("Authorization Complete")
                
            }
        }
}


