//
//  ExpandableTableView.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/21.
//

import UIKit

class ExpandableTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    //테이블 데이터 구조
    struct ExpandableData {
        var isExpanded: Bool
        let cellNames: [String]
        let headerTitle: String
    }
    
    //테이블 데이터
    var arrData: [ExpandableData] = [ExpandableData]()
    
    let cellName = "cell"

    var showIndePath = false

    @IBOutlet weak var lbSelectedCellName: UILabel!
    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableData() //Set data
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Index Path", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
    }

//MARK: - Prepare TableView

    @objc func handleShowIndexPath() {
        print("Attemping reload animation of indexPath...")
        
        var indexPathToReload = [IndexPath]()
  
        for section in arrData.indices {
            print(section)

            if arrData[section].isExpanded {
                for row in arrData[section].cellNames.indices {
                    print(section, row)
                    
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathToReload.append(indexPath)
                }
            }
        }
        
        showIndePath = !showIndePath
        
        let animationStyle = showIndePath ? UITableView.RowAnimation.right : .left
        
        
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    //Set data for expandable TableView
    func initTableData() {
        let expandableData = ExpandableData.init(isExpanded: false, cellNames: ["Apple", "Samsung", "Google"], headerTitle: "Phone Productor")
        arrData.append(expandableData)

        let expandableData2 = ExpandableData.init(isExpanded: false, cellNames: ["MacOS", "Window", "Linux"], headerTitle: "Operating System")
        arrData.append(expandableData2)

        
        let expandableData3 = ExpandableData.init(isExpanded: false, cellNames: ["GitHub", "SVN", "SourceSafe"], headerTitle: "SoftWare Configuration")
        arrData.append(expandableData3)
    }


    //MARK: TableView Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle(arrData[section].headerTitle, for: .normal)
        
        button.backgroundColor = baseColor  //Base color
        button.setTitleColor(baseTextColor, for: .normal)  //Base text color

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        print(button.tag)
        // We'll try to close the section first by deleting the rows
        
        //let section = button.tag
        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in arrData[section].cellNames.indices {
            print(0, row)
            
            let indexPath = IndexPath(row: row, section: section)
            
            indexPaths.append(indexPath)
        }
        //twoDimensionalArray[section].removeAll()
        
        let isExpanded = arrData[section].isExpanded
        arrData[section].isExpanded = !isExpanded
       
        button.setTitle(isExpanded ? arrData[section].headerTitle: "Close", for: .normal)
        
        if isExpanded { //close
            
            tableView.deleteRows(at: indexPaths, with: .fade)
        
        } else {    //insert
            
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    //해더 셀
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
        
    }
    
    //Separate line for Header Cell
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1    //해더뷰 하단 구분 선
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrData.count
    }
    
    //MARK: TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !arrData[section].isExpanded {
            return 0
        }
        
        return arrData[section].cellNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        let name = arrData[indexPath.section].cellNames[indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndePath {
        
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row: \(indexPath.row)"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let selectedCellName = arrData[section].cellNames[row]
        
        self.lbSelectedCellName.text = "\(section) - \(row) : \(selectedCellName)"
    }
}

