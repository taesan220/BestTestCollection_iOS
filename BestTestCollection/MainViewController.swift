//
//  ViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/17.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var categoryTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Category"
        
        self.categoryTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.categoryTableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        
        let index = indexPath.row
        let categoryData: SubCategory = category[index]
            
        let text = String(categoryData.categorySequence) +
            ". " + categoryData.titleName
        
        cell.textLabel?.text = text

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let subCategory = category[index]

        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "catetoryVC") as? CategoryViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
        //Send selected data
        vc.setSubCategoryData(title: subCategory.titleName, listModel: subCategory.listModel)
    }
}
