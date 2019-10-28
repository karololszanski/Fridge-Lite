//
//  FirstViewController.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import UIKit
import SQLite

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var QtyLabel: UILabel!
}

class DataManager {
        static let shared = DataManager()
        var firstVC = FirstViewController()}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resetArray()
        print("Size = ", sizeArray)
        return sizeArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                            as! HeadlineTableViewCell
        cell.headlineTitleLabel?.text = productsArray[indexPath.row].name
        cell.headlineTextLabel?.text = productsArray[indexPath.row].date
        cell.QtyLabel?.text = String(productsArray[indexPath.row].qty)

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            print("Index product: ", productsArray[indexPath.row].id)
            let product = productsTable.filter(id == productsArray[indexPath.row].id)
            if  productsArray[indexPath.row].qty > 1{
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVC") as! PopUpViewController
                popOverVC.updatingQty(row: indexPath.row)
                self.addChild(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: self)
            }
            else {
                let deleteProduct = product.delete()
                do {
                    try databaseData.run(deleteProduct)
                } catch {
                    print(error)
                }
            }
            myTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("products").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            databaseData = database
        } catch { print(error)}
        
        creatingTable()
        DataManager.shared.firstVC = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
    view.endEditing(true)
    }

}

