//
//  HomeViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import HealthKit

class HomeViewController: UIViewController {

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var hrvLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

//    func readProfile() -> (age:Int?, sex:HKBiologicalSex?){
//        do {
//            
//            //1. This method throws an error if these data are not available.
//            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
//            let biologicalSex =       try healthKitStore.biologicalSex()
//            
//            //2. Use Calendar to calculate age.
//            let today = Date()
//            let calendar = Calendar.current
//            let todayDateComponents = calendar.dateComponents([.year], from: today)
//            let thisYear = todayDateComponents.year!
//            let age = thisYear - birthdayComponents.year!
//            
//            //3. Unwrap the wrappers to get the underlying enum values.
//            let unwrappedBiologicalSex = biologicalSex.biologicalSex
//        } catch {
//            
//        }
//        return (age, unwrappedBiologicalSex)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
