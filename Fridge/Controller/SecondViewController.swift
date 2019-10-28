//
//  SecondViewController.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import UIKit
import SQLite

class SecondViewController: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputDate: UIDatePicker!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var stepperQty: UIStepper!
    @IBAction func stepperChanged(_ sender: UIStepper) {
        qtyLabel.text = String(Int(stepperQty.value))
    }
    @IBAction func addItem(_ sender: UIButton) {
        
        let insertProduct = productsTable.insert(name <- inputName.text!,qty <- Int(stepperQty.value), date <- dateToString(date: inputDate))

        do {
            try databaseData.run(insertProduct)
            print("Inserted Product")
        } catch {
            print(error)
        }
        inputName.text = ""
        inputDate.date = Date()
        
        dismiss(animated: true) {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDate.datePickerMode = UIDatePicker.Mode.date
        let currentDate = Date()  //get the current date
        inputDate.minimumDate = currentDate  //set the current date/time as a minimum
        inputDate.date = currentDate //defaults to current time but shows how to use it.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
        }
       
    @objc func dismissKeyboard() {
    view.endEditing(true)
}

    func dateToString(date : UIDatePicker!) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let txtDatePicker = formatter.string(from: date.date)
        return txtDatePicker
    }
}

