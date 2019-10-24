//
//  Data.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import Foundation

class Item {
    var name : String?
    var date : Date
    
    init(name : String, date : Date){
        self.name = name
        self.date = date
    }
}

let test = Item(name: "test", date: stringToDate(dateString: "22/01/2019"))
let test2 = Item(name: "test2", date: stringToDate(dateString: "23/01/2019"))

var products : [Item] = [test, test2]

func stringToDate(dateString : String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    return (dateFormatter.date(from: dateString) ?? nil)!
}
