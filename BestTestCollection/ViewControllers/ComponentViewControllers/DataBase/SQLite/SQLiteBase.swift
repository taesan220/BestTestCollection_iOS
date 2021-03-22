//
//  SQliteBase.swift
//  SQLiteTest
//
//  Created by Taesan Kim on 1/4/19.
//  Copyright © 2019 Taesan Kim. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteBase {
    
    //Containe create table query
    var createTableQuarys:[String] = [String]()
    
    //containe select query result
    var dicDataList: [Dictionary<String, String>] = [Dictionary<String, String>]()
    
    var dataBase:OpaquePointer?!
    
    //Connect DataBase
    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("SmartHomeManager.sql")
        var dataBase: OpaquePointer? = nil
        if (sqlite3_open(fileURL.path, &dataBase) == SQLITE_OK) {
            
            if dataBase != nil {
                self.dataBase = dataBase
                
                //Check created table
                checkCreatedTable(dataBase: dataBase)
            } else {
                
                print("Datafbase cound't be oppened")
                return
            }
        } else {
            sqlite3_errmsg(dataBase)
            return
        }
    }
    
    //Check created table (If the number of tables is different with expection, create new tables)
    private func checkCreatedTable(dataBase: OpaquePointer?) {
    
        //생성한 테이블 네임을 로컬 DB에서 얻어옴
        let tables = select(selectQueryString: "SELECT name FROM sqlite_master WHERE type IN ('table', 'view') AND name NOT LIKE 'sqlite_%' UNION ALL SELECT name FROM sqlite_temp_master WHERE type IN ('table', 'view') ORDER BY 1;")
        
        if tables.count < createTableQuarys.count {
            
            for i in  0...createTableQuarys.count - 1 {
                
                createTable(createTableQueryString: createTableQuarys[i])
            }
        }
    }
    
    //create Table
    private func createTable(createTableQueryString: String) {
        if (dataBase == nil) {
            openDatabase()
        }
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(dataBase, createTableQueryString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("table created.")
            } else {
                print("table could not be created.")
                sqlite3_errmsg(createTableStatement)    //Print recent error log
            }
        } else {
            sqlite3_errmsg(createTableStatement)    //Print recent error log
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)  //SQL OpaquePointer close
    }
    
    //Select key Id
    internal func getKeyId(selectQueryString: String) -> Int32 {
        if (dataBase == nil) {
            openDatabase()
        }
        var queryStatement: OpaquePointer? = nil
        var prymaryId:Int32 = -1
        if sqlite3_prepare_v2(dataBase, selectQueryString, -1, &queryStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                
                //Get first Column of result
                prymaryId = sqlite3_column_int(queryStatement, 0)
            }
        } else {
            print("SELECT statement could not be prepared")
            sqlite3_errmsg(queryStatement)      //Print recent error log

        }
        sqlite3_finalize(queryStatement)        //SQL OpaquePointer close
        
        return prymaryId
    }

    func insertDataWithOutDuplication(tableName: String, pkKey: String, data: Dictionary<String, String>, willUpdate: Bool, condition: Dictionary<String, String>, completion: ((_ insertedRowId: Int) -> Void)? = nil) {
        
        let conditionQuery:String = getQueryConditionString(data: condition)

        let query = "SELECT * FROM \(tableName) WHERE \(conditionQuery)"

        let selectedDatas = select(selectQueryString: query)
        
        //데이터 이미 존재시 DB 업데이트 수행
        if selectedDatas.count > 0 {
            //update

            if willUpdate { //데이터 업데이트
                updateGroupQuery(tableName: tableName, condition: condition, updateData: data)

                if (completion != nil) {

                    if let pkValue:Int = Int(selectedDatas[0][pkKey]!) {
                        completion!(pkValue)
                        return
                    }

                }

            }
            
            if completion != nil {
            
                completion!(-1)
            }
            
        } else {
            //insert
            
            var insertInfo:Dictionary<String, String> = data

            for key in data.keys {  //insert이기 때문에 모든 데이터 저장
                insertInfo[key] = data[key]
            }
            
            for key in condition.keys { //insert기 때문에 Where절로 검색한 모든 데이터 저장
                insertInfo[key] = condition[key]
            }
            
            insertInfo["register_date"] = "datetime('now','localtime')"

            let iSuccess = insertData(tableName: tableName, data: insertInfo)
        
            if (completion != nil) {
                
                let resultid = getLastInsertedData()
                var insertedRowids = resultid    //배열형 값 리턴을 위해 배혈 변수 생성
                
                completion!( insertedRowids)
            }
        }
        
        
        //=========================================================================================================
        func updateGroupQuery(tableName: String, condition: Dictionary<String, String>, updateData: Dictionary<String, String>) -> String {
            

            let updateDataQuery:String = getQueryDataString(data: updateData)
            let updateConditionQuery:String = getQueryConditionString(data: condition)
            
            if (updateConditionQuery == "" || updateConditionQuery == "") {
                return ""
            }
            
            let query:String = "UPDATE \(tableName) SET \(updateDataQuery) WHERE \(updateConditionQuery);"
            
            return query;
        }
    }
    
    
    internal func insertData(tableName: String , data: Dictionary<String, String>) -> Bool  {
        
        
        var keys:[String] = [String]()
        var values:[String] = [String]()
        
        for key in data.keys {
            keys.append(key)
            values.append(data[key] ?? "")
        }
        
        
        if (keys.count < 1) {
            
            print("No insert data")
            return false
        }
        
        return insertQuery(tableName: tableName , keys: keys, values: values);
    }
    
    
    internal func insertQuery(tableName:String , keys:[String], values:[String]) -> Bool  {
        var keysQuery:String = "";
        var valuesQuery:String = "";
        
        
        
        for i in 0..<keys.count {
            if (i > 0) {
                keysQuery += ", "
                valuesQuery += ", "
            }
            
            keysQuery += keys[i]
            
            if(keys[i].hasSuffix("date")) { //date로 끝나는 키이면
              
                valuesQuery += values[i]

            } else {
                valuesQuery += "'" + values[i] + "'"

            }
        }
        
        
        let insertQueryString = "INSERT INTO \(tableName) (\(keysQuery)) VALUES (\(valuesQuery));"
        
        return commonQuery(queryString: insertQueryString)
    }
    
    func getLastInsertedData() -> Int {
        
        if (dataBase == nil) {
            openDatabase()
        }
        return Int(sqlite3_last_insert_rowid(dataBase))
    }
    
    //Insert/Delete/Update Data
    internal func commonQuery(queryString: String) -> Bool {
        
        var isSuccess: Bool = false
        
        if (dataBase == nil) {
            openDatabase()
        }
        
        var containerQueryResultStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(dataBase, queryString, -1, &containerQueryResultStatement, nil) == SQLITE_OK {

            if sqlite3_step(containerQueryResultStatement) == SQLITE_DONE {
                //Success insert data
                print("Successfully finished SQLite task.")
                
                isSuccess = true
               
            } else {
                sqlite3_errmsg(containerQueryResultStatement)    //Print recent error log
                print("error appeared in step \n ffailure inserting")
                
                isSuccess = false
            }
        } else {
            sqlite3_errmsg(containerQueryResultStatement)    //Print recent error log
            print("INSERT statement could not be prepared")
            
            isSuccess = false
        }
        
        sqlite3_finalize(containerQueryResultStatement) //SQL OpaquePointer close
        
        return isSuccess
    }

    
    //Select Data
    internal func select(selectQueryString: String) -> [Dictionary<String, String>] {
        if (dataBase == nil) {
            openDatabase()
        }
        var queryStatement: OpaquePointer? = nil
        
        var dicDataList: [Dictionary<String, String>] = [Dictionary<String, String>]()
        
        if sqlite3_prepare_v2(dataBase, selectQueryString, -1, &queryStatement, nil) == SQLITE_OK {
            

            while(sqlite3_step(queryStatement) == SQLITE_ROW) {
                var dictionary: Dictionary<String, String> = Dictionary<String, String>()
                    
                let columnColumnscount = sqlite3_column_count(queryStatement)
                    
                for i in 0...columnColumnscount - 1 {
                    let columnName = String(cString:sqlite3_column_name(queryStatement, i))
                    
                    if let data  = sqlite3_column_text(queryStatement, i) {
                        
                        let dataString = String(cString: data)
                        
                        dictionary[columnName] = dataString

                    } else {
                        
                        let data  = sqlite3_column_int(queryStatement, i)
                            
                        let dataString = String(data)
                        
                        dictionary[columnName] = dataString
                    }
                }
                
                dicDataList.append(dictionary)
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(dataBase!))//Print recent error log
            print("SELECT statement could not be prepared \n data: \(errmsg)")
        }
        
        sqlite3_finalize(queryStatement)    //SQL OpaquePointer close
        
        return dicDataList
    }
    
    
//MARK: - Query string data maker
    
    func insertGroupQuery(tableName: String, insertKeys: [String], insertValues: [String]) -> String {
        
        let insertQuery = "INSERT INTO\(tableName) (\(insertKeys)) VALUES (\(insertValues));"
        
        print(insertQuery)
        
        return insertQuery
    }

    func updateGroupQuery(tableName: String, condition: Dictionary<String, String>, updateData: Dictionary<String, String>) -> String {
        

        let updateDataQuery:String = getQueryDataString(data: updateData)
        let updateConditionQuery:String = getQueryConditionString(data: condition)
        
        if (updateConditionQuery == "" || updateConditionQuery == "") {
            return ""
        }
        
        let query:String = "UPDATE \(tableName) SET \(updateDataQuery) WHERE \(updateConditionQuery);"
        
        return query;
    }
    
    
    internal func updateQuery(tableName: String , data: Dictionary<String, String>, condition: String) -> String  {
        
        
        let queryParameter = getQueryDataString(data: data)
        
        if queryParameter == "" {
            return ""
        }
        
        return "UPDATE \(tableName) SET \(queryParameter) WHERE \(condition)"
    }
    
    internal func deleteQuery(tableName: String , conditionData: Dictionary<String, String>) -> String  {
        
        
        let conditionString = getQueryConditionString(data: conditionData)
        
        if conditionString == "" {
            return ""
        }
        
        return "DELETE FROM \(tableName) WHERE \(conditionString)"
    }
    
    
    func getQueryDataString(data: Dictionary<String, String>) -> String {
        
        var queryData:String = ""
        
        var keys:String = ""
        var values:String = ""
        
        var i:Int = 0
        
        for key in data.keys {
            
            queryData = queryData + key + "='" + data[key]! + "'"
            
            if (i < data.keys.count - 1) {
                queryData = queryData + ", "
            }
            
            //Todo String 값이면 ''를 붙이고 아니면 안붙임 (일단 무조껀 붙임)
            
            i += 1
        }
        
        return queryData
    }
    
    func getQueryConditionString(data: Dictionary<String, String>) -> String {
        
        var queryData:String = ""

        var i:Int = 0
        
        for key in data.keys {
            if (i != 0) {
                queryData += " AND "
            }
            
            let values = data[key] ?? ""
            
            //Todo String 값이면 ''를 붙이고 아니면 안붙임 (일단 무조껀 붙임)
            
            queryData += "\(key) = '\(values)'"
            
            i += 1
        }
        
        return queryData
    }
}
