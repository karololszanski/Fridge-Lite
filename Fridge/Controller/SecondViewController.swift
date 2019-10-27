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
    @IBAction func addItem(_ sender: UIButton) {
        
        let insertProduct = productsTable.insert(name <- inputName.text!,qty <- 1, date <- dateToString(date: inputDate))

        do {
            try databaseData.run(insertProduct)
            print("Inserted Product")
        } catch {
            print(error)
        }
        inputName.text = ""
        inputDate.date = Date()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

