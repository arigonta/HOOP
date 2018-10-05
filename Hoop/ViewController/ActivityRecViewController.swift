//
//  ActivityRecViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit



class ActivityRecViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var heartImage: String?
    var selectedIndex: Int?
    var act: [activity] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return act.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityTableViewCell", for: indexPath) as! ActivityRecTableViewCell
        
        cell.activityLbl.text = act[indexPath.row].text
        if heartImage == "green" {
            cell.activityImg.image = UIImage(named: "activityBtn")
        }
        else if heartImage == "yellow" {
            cell.activityImg.image = UIImage(named: "YellowBar")
        }
        else if heartImage == "red" {
            cell.activityImg.image = UIImage(named: "RedBar")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if heartImage! == "green" {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.5933555961, green: 0.7535129189, blue: 0.7118578553, alpha: 1)
            }
            else if heartImage! == "yellow" {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9725490196, blue: 0.5843137255, alpha: 1)
            }
            else if heartImage! == "red" {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.5019607843, blue: 0.5058823529, alpha: 1)
            }
            cell.contentView.layer.cornerRadius = 10
        }
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailActivity", sender: self)
    }
    
    @IBAction func unwindToActivityRec(_ sender: UIStoryboardSegue) {
        let sourceViewController = sender.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBOutlet weak var activityTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailActivityViewController{
            destination.activities = act[selectedIndex!].text
            destination.heartCondition = heartImage
        }
        else if let destination = segue.destination as? HistoryViewController{
            destination.heartImage = heartImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        act.append(activity(text: "Breathing"))
        act.append(activity(text: "Jogging"))
        act.append(activity(text: "Meditate"))
        act.append(activity(text: "Healthy Food"))
        act.append(activity(text: "Healthy Sleep"))
        activityTableView.estimatedRowHeight = 200
        activityTableView.rowHeight = UITableView.automaticDimension
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
