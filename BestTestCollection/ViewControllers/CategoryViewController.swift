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
    
    
    let cellReuseIdentifier = "subCell"

    var navigationBarTitle: String!
    var listModel: ListModel!

    //var arrSubCategory: [ListModel]!

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = navigationBarTitle
        self.subCategoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        print("Sub category key = \(subCategoryKey ?? "nil")")
        print("Identifier title = \(subCategoryKey ?? "nil")")
        
        self.navigationItem.title = self.navigationTitle  //상단 타이틀 변경
    }
    
    func setSubCategoryData(title: String, listModel: ListModel) {
        self.navigationBarTitle = title
        self.listModel = listModel
    }

//MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        guard let identifierKey: [Dictionary<String, String>] = arrSubCategory[VIEWCONTROLLERS] as? [Dictionary<String, String>] else {
//            return 0
//        }
        
        return listModel.viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.subCategoryTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        
//        guard let identifierKey: [Dictionary<String, String>] = arrSubCategory[VIEWCONTROLLERS] as? [Dictionary<String, String>] else {
//            return cell
//        }
        
        let index = indexPath.row
        
//        let viewControllerInfo: Dictionary<String, String> = identifierKey[index]
        
        let name = self.listModel.viewControllers[index].subViewControllerName
        //subViewControllerName: "Custom Button", subViewControllerIdentifier: "custombuttonVC")



        let text = String(index + 1) +
            ". " + name
        
        cell.textLabel?.text = text

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboarName:String = listModel.storyboardName
        let identifier:String = listModel.viewControllers[indexPath.row].subViewControllerIdentifier

        print("storyboard name = \(storyboarName)")
        
//        let viewControllerInfo:[Dictionary<String, String>] = arrSubCategory[VIEWCONTROLLERS] as! [Dictionary<String, String>]
//        let identifier: String = viewControllerInfo[indexPath.row][SUB_VIEWCONTROLLER_ITENTIFIER]!
//        
// 
        let vc = UIStoryboard(name: storyboarName, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.show(vc, sender: self)
    }
}
