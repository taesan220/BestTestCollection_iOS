//
//  DataBaseCenter.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import Foundation

class DataBaseCenter: SQLiteBase {
        
    override init() {
        super.init();
        
        setCreateTableQuery()
        
        if (dataBase == nil) {
            super.openDatabase()
        }
        
        //Save DataBase Version
        UserDefaults.standard.setValue("1", forKey: "local_db_version")
    }
    
    //initialize Table
    func setCreateTableQuery() {
        let tableListCount:Int = createTableList.count
        
        for i in 0...tableListCount - 1 {
            super.createTableQuarys.append(createTableList[i])
        }
    }
    
}
