//
//  DetailActivityViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 23/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class DetailActivityViewController: UIViewController {

    var activities:String = ""
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if activities == "Breathing"{
            showImg.image = #imageLiteral(resourceName: "subtitles-dharmawangsa-K26549-idzn0mg5nfh")
            titleLbl.text = activities
            descLbl.text = "Breathe in! It's just a bad day, not a bad life"
        }else if activities == "Jogging"{
            showImg.loadGif(name: "Jogging")
            titleLbl.text = activities
            descLbl.text = "Jogging is very beneficial. It's good for your legs and your feet. It's also very good for the ground. It makes it feel needed\n\n-Charles M Schulz-"
        }else if activities == "Meditate"{
            showImg.loadGif(name: "Meditation")
            titleLbl.text = activities
            descLbl.text = "Quite the mind, and the soul will speak\n\n-Ma Jaya Sati Bhagavati-"
        }else if activities == "Healthy Food"{
            showImg.loadGif(name: "Healthy Food")
            titleLbl.text = activities
            descLbl.text = "4 sehat 5 sempurna"
        }else if activities == "Healthy Sleep"{
            showImg.loadGif(name: "Healthy Sleep")
            titleLbl.text = activities
            descLbl.text = "Nina Bobo"
        }
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
