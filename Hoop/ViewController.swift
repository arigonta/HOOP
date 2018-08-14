//
//  ViewController.swift
//  Hoop
//
//  Created by Brandon Cornelius on 14/08/18.
//  Copyright © 2018 Brandon Cornelius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var test:Int
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

