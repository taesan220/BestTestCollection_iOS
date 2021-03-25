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

        //현재 앱 버전
        guard let appVersion:String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return }
        self.tfCurrentVersion.text = appVersion
        
    }
    
    func initView() {
        self.btnVersionCompare.backgroundColor = baseColor
        self.btnVersionCompare.tintColor = baseTextColor
        
        self.btnUpdate.backgroundColor = baseColor
        self.btnUpdate.tintColor = baseTextColor
    }

//MARK: - Button Event

    @IBAction func versionCompareButtonPressed(_ sender: Any) {
        
        let checkNewVersion = self.tfCurrentVersion.text?.compare(tfUpToDateVersion.text!, options: .numeric)
        
        //최신 버전이 아니면
        switch checkNewVersion {
        case .orderedAscending :    //버전 업데이트가 필요한 경우
            print("버전 업데이트가 필요 합니다.")
            btnUpdate.isEnabled = true
            self.btnUpdate.isHidden = false
            break
        case .orderedDescending :   //현재 앱 버전이 더 큰경우
            print("현재 앱 버전이 서버 버전보다 더 높습니다.")
            //버전이 최신 버전이면 그냥 통과
            self.btnUpdate.isEnabled = false
            self.btnUpdate.isHidden = true
            break
        case .orderedSame :         //현재 버전과 서버 최신 버전이 같은경우
            print("현재 앱이 최신 버전 입니다.")
            //버전이 최신 버전이면 그냥 통과
            self.btnUpdate.isEnabled = false
            self.btnUpdate.isHidden = true
            break
        case .none:
            print("버전 비교 오류")
        }
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
    }
}
