//
//  StudentDB.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import Foundation

class StudentDB: DataBaseCenter {
    
    static let shared = StudentDB()
    
    override init() {
        super.init()
    }
    
    //MARK: About serch
    //Search all students
    func selectStudentList() -> [Dictionary<String, String>] {
        
        let query = "SELECT * FROM student ORDER BY modify_date DESC"  //fromDate가 nil 이면 전체 리스트를 가져옴
        
        let dicResult = select(selectQueryString: query)
            
        return dicResult
    }

    
    //Search student info by student number
    func selectStudent(studentNumber: String) -> Dictionary<String, String>? {
        
        let query = "SELECT * FROM student WHERE number = '\(studentNumber)' ORDER BY modify_date DESC"
        
        let dicResult = select(selectQueryString: query)
            
        if dicResult.count > 0 {
            return dicResult[0]
        }
        
        return nil
    }
    
    //Search students by a part of name
    func selectStudent(byName name: String) -> [Dictionary<String, String>]? {
        
        let query = "SELECT * FROM student WHERE name LIKE '%\(name)%'"
        let dicResult = select(selectQueryString: query)
        
        return dicResult
    }
    
    
    //Insert students with name
    func insertStudent(name: String) -> Int {
        
        _ = insertQuery(tableName: "student", keys: ["name"], values: [name])
        let insertRow = getLastInsertedData()
        return insertRow
    }
    
    //insert
    func insertStudentWithoutDuplication(name: String){

        var insertParameter: Dictionary<String, String> = Dictionary<String, String>()

        insertParameter["name"] = name

        var condition = Dictionary<String, String>()
        condition["name"] = name

        insertDataWithOutDuplication(tableName: "student", pkKey: "id", data: insertParameter, willUpdate: true, condition: condition, completion: nil)

    }
    
    //Update student name by number
    func updateStudentInfo(preName: String, afterName: String) -> Bool {
        let updateQueryString = "UPDATE student SET name = '\(afterName)' WHERE name = '\(preName)';"
        return commonQuery(queryString: updateQueryString)
    }
    
    //Delete student info by name
    func deleteStudentInfo(name: String) -> Bool {
        
        
        let query = "DELETE FROM student WHERE name = '\(name)'"
        
        let result = commonQuery(queryString: query)
        
        if !result {
            print("deleteSearchedWords - 삭제 실패")
        }
    
        return result
    }
}
