//
//  HeartInterfaceController.swift
//  Hoop
//
//  Created by Mohammad Rahimyarza Bagagarsyah on 29/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import WatchKit
import HealthKit
import WatchConnectivity

class HeartInterfaceController: WKInterfaceController, HKWorkoutSessionDelegate {
    
    var wcSession: WCSession?
    @IBOutlet var startLabel: WKInterfaceLabel!
    @IBOutlet var bpmLabel: WKInterfaceLabel!
    var currentQuery:HKQuery?
    let health = HKHealthStore()
    var workoutActive = false
    var session: HKWorkoutSession?
    var heartRateUnit = HKUnit(from: "count/min")
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        wcSession = WCSession.default
        wcSession?.delegate = self
        wcSession?.activate()
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
//        observerHeartRateSamples()
        startStreaming()
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            workoutDidStart(date)
        case .ended:
            workoutDidEnd(date)
        default:
            print("Unexpected state \(toState)")
        }
    }
    
    func workoutDidStart(_ date : Date) {
        if let query = createHeartRateStreamingQuery(date) {
            self.currentQuery = query
            health.execute(query)
        } else {
            bpmLabel.setText("cannot start")
        }
    }
    
    func workoutDidEnd(_ date : Date) {
        print("Stopping...")
            health.stop(currentQuery!)
            session = nil
    }
    
   
    
    func createHeartRateStreamingQuery(_ workoutStartDate: Date) -> HKQuery? {
        bpmLabel.setText("Reading...")
        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else { return nil }
        let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictEndDate )
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate])
        
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            self.updateHeartRate(sampleObjects)
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            self.updateHeartRate(samples)
        }
        return heartRateQuery
    }
    
    func startWorkout() {
        bpmLabel.setText("Starting...")
        if (session != nil) {
            return
        }
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .crossTraining
        workoutConfiguration.locationType = .indoor
        
        do {
            session = try HKWorkoutSession(configuration: workoutConfiguration)
            session?.delegate = self
            
            health.start(session!)
        } catch {
            fatalError("Unable to create the workout session!")
        }
    }
    
    func updateHeartRate(_ samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {
            return
        }
        
        DispatchQueue.main.async {
            guard let sample = heartRateSamples.first else{return}
            let value = sample.quantity.doubleValue(for: self.heartRateUnit)
            let bpmText = String(UInt16(value)) + " BPM"
            let message = ["bpm":value]
            
            do {
                try self.wcSession?.updateApplicationContext(message)
            } catch {
                print("Fail to send message")
            }
            self.bpmLabel.setText(bpmText)
        }
    }
    
    func stopStreaming() {
        self.workoutActive = false
        if let workout = self.session {
            health.end(workout)
        }
    }
    
    func startStreaming() {
        if (self.workoutActive) {
            stopStreaming()
        } else {
            self.workoutActive = true
            startWorkout()
        }
        
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print(error)
    }
}

extension HeartInterfaceController:WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("\(#function)\(session)")
    }
    
}
