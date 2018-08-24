//
//  HistoryViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData

var historyInit = [History]()
//var managedObjectContext: NSManagedObjectContext!
var selectedIndex: Int?

class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyInit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hist = historyInit[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        // Configure the cell...
        cell.setHistory(his: hist)
        return cell
    }
    
    func fetchData() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        do {
            let fetch: NSFetchRequest = History.fetchRequest()
            historyInit = try context.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Hoop HD "))
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
