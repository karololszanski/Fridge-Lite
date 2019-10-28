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
    var whichMode = 0 //O - delete; Else - update
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBAction func stepperQty(_ sender: UIStepper) {
        qtyLabel.text = String(Int(stepperValue.value))
    }
    @IBAction func buttonPopUp(_ sender: UIButton) {
        
        if whichMode == 0 {
            deleteProduct()
        } else {
            updateProduct()
        }
        
        DataManager.shared.firstVC.myTableView.reloadData()
        self.view.removeFromSuperview()
    }
    
    func deleteProduct(){
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
    }
    
    func updateProduct(){
        let product = productsTable.filter(id == productsArray[productRow].id)
        let updateProduct = product.update(qty <- Int(stepperValue.value))
        do {
            try databaseData.run(updateProduct)
            } catch {
                print(error)
        }
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        stepperValue.minimumValue = 1
        stepperValue.value = 1
        if whichMode == 0 {
            stepperValue.maximumValue = Double(productsArray[productRow].qty)
        } else {
            qtyLabel.text = "How many products do you have?"
            buttonLabel.setTitle("Update", for: UIControl.State.normal)
            qtyLabel.text = "1"
        }
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    func updatingQty(row : Int, whichMode: Int){
        productRow = row
        self.whichMode = whichMode
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
