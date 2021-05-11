//
//  3PartyConnectionViewController.swift
//  BestTestCollection
//
//  Created by sdev-mac on 2021/04/06.
//

import UIKit

class FirebaseViewController: UIViewController {

    //MARK: - Global veriable

        @IBOutlet weak var btnSendLog: UIButton!
    
    
    //MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()

            initView()
        }
    
    
    //MARK: - init
        func initView() {
            self.btnSendLog.backgroundColor = baseColor
            self.btnSendLog.tintColor = baseTextColor
        }
    
    
    //MARK: - Button Event
    @IBAction func sendLogButtonPressed(_ sender: Any) {

        FirebaseLog.shared.sendLogToEvent()
        
        FirebaseLog.shared.sendLogToRealTimeDataBase()
        
        FirebaseLog.shared.sendLogToFireStore()
    }
}
