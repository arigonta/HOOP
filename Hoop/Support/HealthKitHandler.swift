//
//  HealthKitHandler.swift
//  Hoop
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 21/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
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
        HKHealthStore().requestAuthorization(toShare: infoToWrite,
                                             read: infoToRead) { (success, error) in
                                                completion(success, error)
        }
    }
}

struct activity
{
    let text: String
    //    let gambar: uiimage
}

class ProfileDataStore {
    
   class func getAgeAndSex() throws -> (age: Int,
        biologicalSex: HKBiologicalSex) {
            
            let healthKitStore = HKHealthStore()
            
            do {
                
                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
                let biologicalSex =       try healthKitStore.biologicalSex()
                
                //2. Use Calendar to calculate age.
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let thisYear = todayDateComponents.year!
                let age = thisYear - birthdayComponents.year!
                
                //3. Unwrap the wrappers to get the underlying enum values.
                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                
                return (age, unwrappedBiologicalSex)
            }
            
    }
}


