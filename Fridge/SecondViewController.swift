//
//  SecondViewController.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputDate: UIDatePicker!
    @IBAction func addItem(_ sender: UIButton) {
        if inputName.text != nil {
            products.append(Item(name: inputName.text!, date: inputDate.date))
        }
        inputName.text = ""
        inputDate.date = Date()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
            // Do any additional setup after loading the view.
        }
       
    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
}


}

