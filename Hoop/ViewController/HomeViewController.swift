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

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var hrvLabel: UILabel!
    @IBOutlet weak var heartImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        heartImg.loadGif(name: "HeartRate")
        do {
            let userAgeAndSex = try ProfileDataStore.getAgeAndSex()
            /*ageLabel.text = "\(userAgeAndSex.age)"*/
            let sex = userAgeAndSex.biologicalSex.rawValue
            var sexString:String = ""
            switch sex {
            case 1:
                sexString = "Female"
            case 2:
                sexString = "Male"
            default:
                sexString = "Other"
            }
//            bpmLabel.text = sexString
            
        } catch {
            
        }
        // Do any additional setup after loading the view.
    }
    
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
