//
//  detailHistoryViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 27/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData

class detailHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableViewDetailHistory: UITableView!
    @IBOutlet weak var beforeBpmLabel: UILabel!
    @IBOutlet weak var afterBpmLabel: UILabel!
    var history: [History]?
    var beforeBpm: Int = 0
    var afterBpm: Int = 0
    var sectionTitle = ["Before", "After"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryTableViewCell", for: indexPath) as! DetailHistoryTableViewCell
        if indexPath.section == 0 {
            cell.activityLabel.text = history![indexPath.row].activityName
            cell.bpmLabel.text = "\(history![indexPath.row].beforeHeartCondition)"
            cell.timeLabel.text = history![indexPath.row].startTime
        } else if indexPath.section == 1 {
            cell.activityLabel.text = history![indexPath.row].activityName
            cell.bpmLabel.text = "\(history![indexPath.row].afterHeartCondition)"
            cell.timeLabel.text = history![indexPath.row].endTime
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let label = UILabel()
        
        if section == 0
        {
            label.text = "Before"
            label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        else
        {
            label.text = "After"
            label.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }
        
        return label
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    
    func averageBpm() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        var totalCount = 0
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                totalCount = result.count
                for res in result as! [NSManagedObject] {
                    if let before = res.value(forKey: "beforeHeartCondition") as? Int {
                        beforeBpm = beforeBpm + before
                        print(before)
                        print(beforeBpm)
                    }
                    if let after = res.value(forKey: "afterHeartCondition") as? Int {
                        afterBpm = afterBpm + after
                        print(after)
                        print(afterBpm)
                    }
                }
            }
        } catch  {
            print("Error retrieving data!")
        }
        beforeBpmLabel.text = "Avg before = \(beforeBpm/totalCount)"
        afterBpmLabel.text = "Avg after = \(afterBpm/totalCount)"
    }
    
    
 
    
var heartImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        averageBpm()
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
