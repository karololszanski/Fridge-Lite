//
//  PopUpViewController.swift
//  Fridge
//
//  Created by Karol Olszański on 28/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import UIKit
import SQLite

class PopUpViewController: UIViewController {
    
    var productRow = 0
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBAction func stepperQty(_ sender: UIStepper) {
        qtyLabel.text = String(Int(stepperValue.value))
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        let product = productsTable.filter(id == productsArray[productRow].id)
        let updateProduct = product.update(qty <- qty - Int(stepperValue.value))
        if productsArray[productRow].qty - Int(stepperValue.value) == 0{
            let deleteProduct = product.delete()
            do {
                try databaseData.run(deleteProduct)
            } catch {
                print(error)
            }
        } else {
                do {
                    try databaseData.run(updateProduct)
                } catch {
                    print(error)
                }
        }
        DataManager.shared.firstVC.myTableView.reloadData()
        self.view.removeFromSuperview()
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        stepperValue.minimumValue = 1
        stepperValue.value = 1
        stepperValue.maximumValue = Double(productsArray[productRow].qty)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    func updatingQty(row : Int){
        productRow = row
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
