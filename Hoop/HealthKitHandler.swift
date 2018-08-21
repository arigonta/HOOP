//
//  HealthKitHandler.swift
//  Hoop
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 21/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import HealthKit


func authorizeHealthKit() {
    
    let healthKitStore:HKHealthStore = HKHealthStore()

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
    } else {
        let alertController = UIAlertController(title: "Sorry", message: "Your device is not supported", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
