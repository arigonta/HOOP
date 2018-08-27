//
//  DemoScreen.swift
//  Hoop
//
//  Created by Ari Gonta on 8/14/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import paper_onboarding
import CoreData
import HealthKit

class DemoScreen: UIViewController {
    //view onboarding outlet
    
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var onboardingOutlet: OnboardingViewClass!
    
    //Variable
    var userData = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingOutlet.dataSource = self
        onboardingOutlet.delegate = self
    }
    
    //Action
    @IBAction func doneBtnPressed(_ sender: Any) {
        userData.set(true, forKey: "demoCompleted")
        userData.synchronize()
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        performSegue(withIdentifier: "tutorialToProfile", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension DemoScreen : PaperOnboardingDataSource, PaperOnboardingDelegate
{
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let bgOne = #colorLiteral(red: 0.6823529412, green: 0.9294117647, blue: 0.8705882353, alpha: 1)
        let bgTwo = #colorLiteral(red: 1, green: 0.7491034865, blue: 0.2262120843, alpha: 1)
        let bgThree = #colorLiteral(red: 1, green: 0.7491034865, blue: 0.2262120843, alpha: 1)
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let titleFont = UIFont(name: "Helvetica-Bold", size: 20)!
        let descFont = UIFont(name: "Helvetica", size: 15)!
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "1"),
                               title: "",
                               description: "HOOP is an app to help you to create good habits for your health.",
                               pageIcon: #imageLiteral(resourceName: "active"),
                               color: bgTwo,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "2"),
                               title: "",
                               description: "We are here to make you become even better than before",
                               pageIcon: #imageLiteral(resourceName: "active"),
                               color: bgOne,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "subtitles-dharmawangsa-K26549-idzn0mg5nfh"),
                               title: "",
                               description: "Subtitles is a good place",
                               pageIcon: #imageLiteral(resourceName: "active"),
                               color: bgThree,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont)][index]
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            doneOutlet.isHidden = false
        }
    }
    
    @objc(onboardingWillTransitonToIndex:) func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 2 {
            if doneOutlet.isHidden == false {
                doneOutlet.isHidden = true
            }
        }
    }
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    func showAlert(title: String, message: String, action: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
