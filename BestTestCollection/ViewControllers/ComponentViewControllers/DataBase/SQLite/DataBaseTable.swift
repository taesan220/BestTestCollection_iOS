//
//  DatabaseTable.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import Foundation

let createTableList = [
    
    "CREATE TABLE IF NOT EXISTS student(id INTEGER PRIMARY KEY AUTOINCREMENT, name CHAR(30), number CHAR(8), state INTEGER DEFAULT 1, modify_date DATETIME DEFAULT (datetime('now','localtime')), register_date DATETIME);"
    ]
