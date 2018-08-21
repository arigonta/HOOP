//
//  ActivityRecViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

struct activity
{
    let text: String
//    let gambar: uiimage
}

class ActivityRecViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var act: [activity] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return act.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityTableViewCell", for: indexPath) as! ActivityRecTableViewCell
        
        cell.activityLbl.text = act[indexPath.row].text
        return cell
    }

    
    @IBOutlet weak var activityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        act.append(activity(text: "Breathing"))
        act.append(activity(text: "Jogging"))
        act.append(activity(text: "Meditate"))
        act.append(activity(text: "Running"))
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
