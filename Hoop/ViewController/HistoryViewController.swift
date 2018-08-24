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
var managedObjectContext: NSManagedObjectContext!
var selectedIndex: Int?

class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyInit.count
    }
    @IBOutlet weak var historyTableViewq: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hist = historyInit[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        // Configure the cell...
        cell.setHistory(his: hist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9215686275, blue: 0.6862745098, alpha: 1)
            cell.contentView.layer.cornerRadius = 10
        }
//        selectedIndex = indexPath.row
//        performSegue(withIdentifier: "detailActivity", sender: self)
    }
    
    func loadData() {
        let wordRequest: NSFetchRequest<History> = History.fetchRequest()
        
        do {
            historyInit = try managedObjectContext.fetch(wordRequest)
            self.historyTableViewq.reloadData()
        } catch {
            print("Fetch failed!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
        
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
