//
//  ViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 14/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    var users:[User] = []
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    func showAlert(title: String, message: String, action: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Variable
    var userData = UserDefaults.standard
    var dates:String = ""
    
    //action
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if nameTxt.text != "" && dobTxt.text != ""{
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            
            do {
                //validasi apakah user sudah terdaftar atau belum
                let fetch: NSFetchRequest = User.fetchRequest()
                fetch.predicate = NSPredicate(format: "name == %@", (nameTxt.text!))
                users = try context.fetch(fetch)
                
                //apabila user sudah terdaftar
                if users.count > 0 {
                    showAlert(title: "Error", message: "Username has been taken", action: "Dismiss")
                    print("Username has been taken")
                }
                    
                    //apabila user belum terdaftar maka didaftarkan ke user baru
                else {
                    //memasukan data ke dalam model
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                    newUser.setValue(nameTxt.text, forKey: "name")
                    newUser.setValue(dates, forKey: "dob")
                    
                    showAlert(title: "Success", message: "Saved", action: "OK")
                    print("Saved")
                    try context.save()
                    performSegue(withIdentifier: "profileToStart", sender: self)
                    userData.set(true, forKey: "ProfileCompleted")
                    userData.synchronize()
                }
            } catch let error as NSError {
                print("Could not fetch. \(error) \(error.userInfo)")
            }
            
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = CharacterSet.letters
        let setChar = CharacterSet(charactersIn: string)
        
        return char.isSuperset(of: setChar)
    }
    
    let picker = UIDatePicker()
    
    func datePicker(){
        picker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let pick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDone))
        toolbar.setItems([pick], animated: false)
        
        dobTxt.inputAccessoryView = toolbar
        dobTxt.inputView = picker
    }
    @objc func dateDone(){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        dobTxt.text = dateFormat.string(from: picker.date)
        dateFormat.timeStyle = .short
        dates = dateFormat.string(from: picker.date)
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTxt.resignFirstResponder()
        dobTxt.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTxt.delegate = self
        datePicker()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

