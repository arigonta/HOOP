//
//  ViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 14/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    
    //Variable
    var userData = UserDefaults.standard
    
    //action
    @IBAction func saveBtnPressed(_ sender: Any) {
        userData.set(true, forKey: "ProfileCompleted")
        userData.synchronize()
        if nameTxt.text != "" && dobTxt.text != ""{
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
        
        dobTxt.inputAccessoryView = toolbar
        dobTxt.inputView = picker
    }
    @objc func dateDone(){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        dobTxt.text = dateFormat.string(from: picker.date)
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

