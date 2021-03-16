//
//  ViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/17.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let arrCategory = ["UIView", "TableView", "Component", "WebView", "DataBase", "API Connection", "3Party Connection"]
    
    static let TITLE_NAME: String = "title"
    static let SUB_KEY: String = "sub_key"
    static let SEQUENCE = "sequence"
    
    let dicCategory: [Dictionary<String, String>] = [
        [SEQUENCE : "1", TITLE_NAME: "UIView", SUB_KEY: "uiview"],
        [SEQUENCE : "2", TITLE_NAME: "Alert & Toast", SUB_KEY: "alert_toast"],
        [SEQUENCE : "3", TITLE_NAME: "TableView", SUB_KEY: "tableview"],
        [SEQUENCE : "4", TITLE_NAME: "Component", SUB_KEY: "component"],
        [SEQUENCE : "5", TITLE_NAME: "WebView", SUB_KEY: "webview"],
        [SEQUENCE : "6", TITLE_NAME: "DataBase", SUB_KEY: "database"],
        [SEQUENCE : "7", TITLE_NAME: "API Connection", SUB_KEY: "api_connection"],
        [SEQUENCE : "8", TITLE_NAME: "Third party Connection", SUB_KEY: "third_party_connection"]
    ]

    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var categoryTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.categoryTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        
        let index = indexPath.row
        let categoryData = dicCategory[index]
            
        let text = categoryData[MainViewController.SEQUENCE]! +
            ". " + categoryData[MainViewController.TITLE_NAME]!
        
        cell.textLabel?.text = text

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let categoryData = dicCategory[index]
        let titleName = categoryData[MainViewController.TITLE_NAME]!
        let subKey = categoryData[MainViewController.SUB_KEY]!
        let identifier = "catetoryVC"
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? CategoryViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

        vc.initializationPageInfo(navigationTitle: titleName, subCategoryKey: subKey)
        
    }
}
