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
            showImg.image = #imageLiteral(resourceName: "Love")
            titleLbl.text = activities
            descLbl.text = "Jogging is very beneficial. It's good for your legs and your feet. It's also very good for the ground. It makes it feel needed\n\n-Charles M Schulz-"
        }else if activities == "Meditate"{
            showImg.image = #imageLiteral(resourceName: "Hoop HD")
            titleLbl.text = activities
            descLbl.text = "Quite the mind, and the soul will speak\n\n-Ma Jaya Sati Bhagavati-"
        }else if activities == "Running"{
            showImg.loadGif(name: "Running")
            titleLbl.text = activities
            descLbl.text = "One run can change your day, many runs can change your life"
        }else if activities == "Yoga"{
            //showImg.image
            titleLbl.text = activities
            descLbl.text = "Anget"
        }else if activities == "Zumba"{
            //showImg.image
            titleLbl.text = activities
            descLbl.text = "apa coba ini"
        }else if activities == "Swimming"{
            //showImg.image
            titleLbl.text = activities
            descLbl.text = "Swimming regularly can help to decrease anxiety, improve your stress management and boost your overall state of mind"
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
