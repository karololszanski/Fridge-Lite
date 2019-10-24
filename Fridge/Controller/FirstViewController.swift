//
//  FirstViewController.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        //cell.textLabel?.text = products[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                            as! HeadlineTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        //return (dateFormatter.date(from: dateString) ?? nil)!

        cell.headlineTitleLabel?.text = products[indexPath.row].name
        cell.headlineTextLabel?.text = dateFormatter.string(from: products[indexPath.row].date)
        //cell.headlineImageView?.image = UIImage(named: headline.image)

            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            products.remove(at: indexPath.row)
            
            myTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
    }


}

