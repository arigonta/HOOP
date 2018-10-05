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
//        userData.set(true, forKey: "demoCompleted")
//        userData.synchronize()
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
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tutorialToProfile", sender: self)
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension DemoScreen : PaperOnboardingDataSource, PaperOnboardingDelegate
{
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let bgOne = #colorLiteral(red: 0.6823529412, green: 0.9294117647, blue: 0.8705882353, alpha: 1)
        let bgTwo = #colorLiteral(red: 1, green: 0.7491034865, blue: 0.2262120843, alpha: 1)
        let bgThree = #colorLiteral(red: 1, green: 0.7491034865, blue: 0.2262120843, alpha: 1)
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let titleFont = UIFont(name: "Helvetica-Bold", size: 20)!
        let descFont = UIFont(name: "Open Sans", size: 17)!
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "1"),
                               title: "",
                               description: "HOOP is an app to help you to create good habits for your health.",
                               pageIcon: #imageLiteral(resourceName: "1"),
                               color: bgTwo,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "2"),
                               title: "",
                               description: "We are here to make you become even better than before",
                               pageIcon: #imageLiteral(resourceName: "2"),
                               color: bgOne,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "appleWatch"),
                               title: "",
                               description: "Make sure your Apple Watch to pair with HOOP",
                               pageIcon: #imageLiteral(resourceName: "appleWatch"),
                               color: bgThree,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "activityDemo"),
                               title: "",
                               description: "Try our activity recommendation for the best result",
                               pageIcon: #imageLiteral(resourceName: "activityDemo"),
                               color: bgOne,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont)][index]
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            doneOutlet.isHidden = false
        }
    }
    
    @objc(onboardingWillTransitonToIndex:) func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 3 {
            if doneOutlet.isHidden == false {
                doneOutlet.isHidden = true
            }
        }
    }
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    func showAlert(title: String, message: String, action: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
