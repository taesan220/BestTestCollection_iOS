//
//  DynamicHeightTableViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/21.
//

import UIKit

class DynamicHeightTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//MARK: - Global veriable
    @IBOutlet weak var outSideView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var lbTitleView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightLayoutConstraint: NSLayoutConstraint!
    

    @IBOutlet weak var btnAddCell: UIButton!
    @IBOutlet weak var btnDeleteCell: UIButton!
    
    let cellName = "cell"
    
    var arrCellData: [Int]!

    
//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrCellData = [Int]()
        
        self.initView()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
    }
    
    //Set color
    func initView() {
        btnAddCell.backgroundColor = baseColor
        btnAddCell.tintColor = baseTextColor
        btnDeleteCell.backgroundColor = baseColor
        btnDeleteCell.tintColor = baseTextColor
        
        titleView.backgroundColor = baseColor
        titleView.alpha = 0.8   //색을 조금 다르게 하기 위해 알파 지정
        lbTitleView.textColor = baseTextColor
        
        self.outSideView.backgroundColor = baseColor
    }
    
//MARK: - Button Event
    //Add cell
    @IBAction func addCellButtonPressed(_ sender: Any) {
        arrCellData.append(arrCellData.count)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func deleteCellButtonPressed(_ sender: Any) {
        
        if arrCellData == nil || arrCellData.count == 0 {
            return
        }
        
        arrCellData.remove(at: arrCellData.count - 1)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
//MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrCellData == nil || self.arrCellData.count == 0 {
            return 1
        }
        
        return self.arrCellData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if arrCellData == nil || arrCellData.count == 0 {
            return 100
        }
        
        return 44
    }
    
    //테이블의 데이터가 초기화 되고 Cell을 그릴때 호출 되는 메소드
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            //테이블 전체 세로 크기를 계산하여 변경 -> 테이블 뷰는 상위 뷰 사이즈를 넘어서지 않아, 분기처리 따로 안함
            self.tableViewHeightLayoutConstraint.constant = self.tableView.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrCellData == nil || arrCellData.count == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
            
            cell.textLabel?.text = "No data"
            cell.textLabel?.textAlignment = NSTextAlignment.center

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        cell.textLabel?.text = String(arrCellData[indexPath.row])
        cell.textLabel?.textAlignment = NSTextAlignment.left

        return cell
    }
}
