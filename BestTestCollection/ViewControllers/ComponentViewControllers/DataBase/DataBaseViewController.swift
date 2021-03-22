//
//  DataBaseViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import UIKit

class DataBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//MARK: - Global veriable

    @IBOutlet weak var tfNameInsert: UITextField!
    @IBOutlet weak var btnInsert: UIButton!
    
    @IBOutlet weak var tfPreNameUpdate: UITextField!
    @IBOutlet weak var tfAfterNameUpdate: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var tfNameDelete: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrStudentInfo: [Dictionary<String, String>]!
    
    //UIView For hiding keyboard
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var inertView: UIView!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var deleteView: UIView!
    
//MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initEvent()
        
        refresh()   //DB Date load
    }

//MARK: - init

    func initView() {
        btnInsert.backgroundColor = baseColor
        btnInsert.tintColor = baseTextColor
        btnUpdate.backgroundColor = baseColor
        btnUpdate.tintColor = baseTextColor
        btnDelete.backgroundColor = baseColor
        btnDelete.tintColor = baseTextColor
    }
    
    //For hiding keyboard
    func initEvent() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        
        backGroundView.addGestureRecognizer(gesture)
//        updateView.addGestureRecognizer(gesture)
//        deleteView.addGestureRecognizer(gesture)
    }
    
    //Hide keyboard
    @objc func hideKeyboard(_ :UIGestureRecognizer) {
        print("hide kayboard")
        self.view.endEditing(true)
    }
    
    //DB data refresh
    func refresh() {
        self.arrStudentInfo = StudentDB.shared.selectStudentList()
        
        self.tableView.reloadData()
    }

    
//MARK: - Button Event
    
    
    @IBAction func insertButtonPressed(_ sender: Any) {  
        StudentDB.shared.insertStudentWithoutDuplication(name: tfNameInsert.text!)
        
        refresh()
        
        self.view.endEditing(true)
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        StudentDB.shared.updateStudentInfo(preName: tfPreNameUpdate.text!, afterName: tfAfterNameUpdate.text!)
        
        refresh()
        
        self.view.endEditing(true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        StudentDB.shared.deleteStudentInfo(name: tfNameDelete.text!)
        
        refresh()
        
        self.view.endEditing(true)
    }
    
//MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrStudentInfo == nil {
            return 0
        }
        
        return arrStudentInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.lbNo.text = String(indexPath.row + 1)
        cell.lbName.text = arrStudentInfo[indexPath.row]["name"]
        cell.lbModifiDate.text = arrStudentInfo[indexPath.row]["modify_date"]
        return cell
    }
}

//Cell class
class TableViewCell: UITableViewCell {
    @IBOutlet weak var lbNo: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbModifiDate: UILabel!
}
