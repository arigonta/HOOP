////
////  ViewController.swift
////  Hoop
////
////  Created by Brandon Cornelius on 14/08/18.
////  Copyright © 2018 Brandon Cornelius. All rights reserved.
////

import UIKit
import CoreData
import HealthKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTxt: UITextField!
    func showAlert(title: String, message: String, action: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Variable
    var age:Int = 0
    var sex:String = "Other"
    var userData = UserDefaults.standard
    var dates:String = ""
    
    //action
    @IBAction func saveBtnPressed(_ sender: Any) {

        if nameTxt.text != ""{
            HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
                
                guard authorized else {
                    
                    let baseMessage = "HealthKit Authorization Failed"
                    
                    if let error = error {
                        print("\(baseMessage). Reason: \(error.localizedDescription)")
                    } else {
                        print(baseMessage)
                    }
                    
                    return
                }
                
                print("HealthKit Successfully Authorized.")
            }
            
            loadAgeAndSex()
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            
            do {
                let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                newUser.setValue(nameTxt.text, forKey: "name")
                newUser.setValue(age, forKey: "age")
                newUser.setValue(sex, forKey: "sex")
                try context.save()
                userData.set(true, forKey: "ProfileCompleted")
                userData.synchronize()
            } catch let error as NSError {
                print("Could not fetch. \(error) \(error.userInfo)")
            }
            performSegue(withIdentifier: "profileToStart", sender: self)
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
        
    }
    @objc func dateDone(){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        dateFormat.timeStyle = .short
        dates = dateFormat.string(from: picker.date)
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTxt.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        nameTxt.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    func loadAgeAndSex() {
        do {
                        let userAgeAndSex = try ProfileDataStore.getAgeAndSex()
                        age = userAgeAndSex.age
                        switch userAgeAndSex.biologicalSex {
                        case .female:
                            sex = "Female"
                        case .male:
                            sex = "Male"
                        default:
                            sex = "Other"
                        }
                    } catch {
            
                    }
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

