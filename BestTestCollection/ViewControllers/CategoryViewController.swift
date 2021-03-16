//
//  CategoryViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/17.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//MARK: - init
    func initializationPageInfo(navigationTitle title: String, subCategoryKey subKey: String) {
        
        self.navigationTitle = title
        self.subCategoryKey = subKey
    }
    
//MARK: - Global Veriable
    @IBOutlet weak var subCategoryTableView: UITableView!
    var navigationTitle: String!
    var subCategoryKey: String!
    
    static let STORYBOARD_NAME: String = "storyboard_name"
    static let IDENTIFICATION_KEY: String = "identified_key"
    static let VIEWCONTROLLERS = "viewcontrollers"

    static let SUB_VIEWCONTROLLER_NAME = "sub_viewcontroller_name"
    static let SUB_VIEWCONTROLLER_ITENTIFIER = "sub_viewcontroller_identifier"
    
    let cellReuseIdentifier = "subCell"
    
    var subCategoryDatas = [
        [MainViewController.SEQUENCE : "1", MainViewController.SUB_KEY: "uiview",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        

        [MainViewController.SEQUENCE : "2", MainViewController.SUB_KEY: "alert_toast",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
    
    
        [MainViewController.SEQUENCE : "3", MainViewController.SUB_KEY: "tableview",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        
        
        [MainViewController.SEQUENCE : "4", MainViewController.SUB_KEY: "component",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        
        
        [MainViewController.SEQUENCE : "5", MainViewController.SUB_KEY: "webview",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        
        
        [MainViewController.SEQUENCE : "6", MainViewController.SUB_KEY: "database",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        
        
        [MainViewController.SEQUENCE : "7", MainViewController.SUB_KEY: "api_connection",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]],
        
        
        [MainViewController.SEQUENCE : "8", MainViewController.SUB_KEY: "third_party_connection",  STORYBOARD_NAME: "Component",
         VIEWCONTROLLERS : [[SUB_VIEWCONTROLLER_NAME : "Custom Button", SUB_VIEWCONTROLLER_ITENTIFIER : "custombuttonVC"]]]
    ]
    
    var arrSubCategory: Dictionary<String, Any>!

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subCategoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        print("Sub category key = \(subCategoryKey ?? "nil")")
        print("Identifier title = \(subCategoryKey ?? "nil")")
        
        self.navigationItem.title = self.navigationTitle  //상단 타이틀 변경
        
        
        for subCategoryInfo in subCategoryDatas {
            
            if (subCategoryInfo[MainViewController.SUB_KEY] as! String) == subCategoryKey {
                
                arrSubCategory = subCategoryInfo
                
                subCategoryTableView.reloadData()

                return
            }
            
        }
    }

//MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let identifierKey: [Dictionary<String, String>] = arrSubCategory[CategoryViewController.VIEWCONTROLLERS] as? [Dictionary<String, String>] else {
            return 0
        }
        
        return identifierKey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.subCategoryTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        
        guard let identifierKey: [Dictionary<String, String>] = arrSubCategory[CategoryViewController.VIEWCONTROLLERS] as? [Dictionary<String, String>] else {
            return cell
        }
        
        let index = indexPath.row
        
        let viewControllerInfo: Dictionary<String, String> = identifierKey[index]
        
        let name = viewControllerInfo[CategoryViewController.SUB_VIEWCONTROLLER_NAME]

        let text = String(index + 1) +
            ". " + name!
        
        cell.textLabel?.text = text

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboarName:String = arrSubCategory[CategoryViewController.STORYBOARD_NAME] as! String
        
        let viewControllerInfo:[Dictionary<String, String>] = arrSubCategory[CategoryViewController.VIEWCONTROLLERS] as! [Dictionary<String, String>]
        let identifier: String = viewControllerInfo[indexPath.row][CategoryViewController.SUB_VIEWCONTROLLER_ITENTIFIER]!
        
 
        let vc = UIStoryboard(name: storyboarName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
