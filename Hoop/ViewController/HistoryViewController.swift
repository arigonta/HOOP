//
//  HistoryViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 20/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData

var heartImage: String?
var historyInit = [History]()
var managedObjectContext: NSManagedObjectContext!
var selectedIndex: Int?
var date: [String] = []
var histories: [History] = []


class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var heartImage: String?
    
    
    @IBOutlet weak var historyTableViewq: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hist = historyInit[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.HistoryImg.image = UIImage(named: "barHistory")
        cell.HistoryLbl.text = date[indexPath.row]
        cell.setHistory(his: hist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let dateStored = data.value(forKey: "activityDate") as? String {
                    if !date.contains(dateStored) {
                        date.append(dateStored)
                    }
                }
            }
        } catch  {
            print("Error retrieving data!")
        }
        
        
        return date.count
    }
//    @IBAction func unwindToActivityRec(_ sender: UIStoryboardSegue) {
//        let sourceViewController = sender.source
//        // Use data from the view controller which initiated the unwind segue
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9215686275, blue: 0.6862745098, alpha: 1)
            cell.contentView.layer.cornerRadius = 10
        }
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailHistory", sender: self)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if let destination = segue.destination as? ActivityRecViewController{
            destination.heartImage = heartImage
        }
       else if let destination = segue.destination as? detailHistoryViewController{
            destination.heartImage = heartImage
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        guard let detailHistoryViewController = segue.destination as? detailHistoryViewController else { fatalError("Unexpected Destination") }
        
        guard let selectedDateCell = historyTableViewq.indexPathForSelectedRow else {
            fatalError("Unexpected Error")
        }
        
        
        do {
            let fetch: NSFetchRequest = History.fetchRequest()
            let datePredicate = NSPredicate(format: "activityDate == %@", date[selectedDateCell.row])
            fetch.predicate = datePredicate
            histories = try context.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
        
        let selectedHistory = histories
        detailHistoryViewController.history = selectedHistory
        
        
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
