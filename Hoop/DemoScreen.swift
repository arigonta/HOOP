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
        let bgOne = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        let bgTwo = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        let bgThree = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        let textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let titleFont = UIFont(name: "Helvetica-Bold", size: 20)!
        let descFont = UIFont(name: "Helvetica", size: 15)!
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "post-1"),
                               title: "Post",
                               description: "Post is awesome",
                               pageIcon: #imageLiteral(resourceName: "active"),
                               color: bgTwo,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "illustration"),
                               title: "Beer",
                               description: "Beer is awesome",
                               pageIcon: #imageLiteral(resourceName: "active"),
                               color: bgOne,
                               titleColor: textColor,
                               descriptionColor: textColor,
                               titleFont: titleFont,
                               descriptionFont: descFont),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "subtitles-dharmawangsa-K26549-idzn0mg5nfh"),
                               title: "Subtitles",
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
}
