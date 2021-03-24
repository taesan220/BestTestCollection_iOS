//
//  VersionCompareViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/25.
//

import UIKit

class VersionCompareViewController: UIViewController {
    
//MARK: - Global variables

    @IBOutlet weak var btnVersionCompare: UIButton!
    
    @IBOutlet weak var tfCurrentVersion: UITextField!
    @IBOutlet weak var tfUpToDateVersion: UITextField!
    
    @IBOutlet weak var btnUpdate: UIButton!

//MARK: - initialization
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initView() {
        self.btnVersionCompare.backgroundColor = baseColor
        self.btnVersionCompare.tintColor = baseTextColor
        
        self.btnUpdate.backgroundColor = baseColor
        self.btnUpdate.tintColor = baseTextColor
    }

//MARK: - Button Event

    @IBAction func versionCompareButtonPressed(_ sender: Any) {
        
        let isUptoDate = self.tfCurrentVersion.text?.compare(tfUpToDateVersion.text!, options: .numeric)
        
        if isUptoDate == .orderedAscending {     //버전 업데이트가 필요한 경우
            btnUpdate.isEnabled = true
            self.btnUpdate.isHidden = false
            
        } else if isUptoDate == .orderedDescending {    //비교 대상 버전이 더 큰경우
            print("비교 대상 버전이 더 큼")
            self.btnUpdate.isEnabled = false
            self.btnUpdate.isHidden = true
            
        } else if isUptoDate == .orderedSame {      //현재 버전이 최신버전인 경우
            self.btnUpdate.isEnabled = false
            self.btnUpdate.isHidden = true
        }
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
    }
}
