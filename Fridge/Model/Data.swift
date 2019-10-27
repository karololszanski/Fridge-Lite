//
//  Data.swift
//  Fridge
//
//  Created by Karol Olszański on 23/10/2019.
//  Copyright © 2019 Karol Olszański. All rights reserved.
//

import Foundation
import SQLite

var databaseData : Connection!
let productsTable = Table("products")

let id = Expression<Int>("id")
let name = Expression<String?>("name")
let qty = Expression<Int>("qty")
let date = Expression<String>("date")

let createTable = productsTable.create { (table) in
    table.column(id, primaryKey: true)
    table.column(name)
    table.column(qty)
    table.column(date)
}

func creatingTable() {
    print("Creating table")
    do {
        try databaseData.run(createTable)
        print("Created table")
    } catch {
        print(error)
    }
}

class Item {
    var id : Int
    var name : String?
    var qty : Int
    var date : String
    
    init(id : Int,name : String?,qty : Int,date : String){
        self.id = id
        self.name = name
        self.qty = qty
        self.date = date
    }
}

var sizeArray : Int = 0
var productsArray : [Item] = []

func resetArray(){
    sizeArray = 0
    productsArray.removeAll()
    do {
        let products = try databaseData.prepare(productsTable)
        for product in products {
            productsArray.append(Item(id: product[id],name: product[name], qty: product[qty], date: product[date]))
            print(product[id], product[name], product[qty], product[date])
            sizeArray = sizeArray + 1
        }
    } catch {
        print(error)
    }
}

func stringToDate(dateString : String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    return (dateFormatter.date(from: dateString) ?? nil)!
}
