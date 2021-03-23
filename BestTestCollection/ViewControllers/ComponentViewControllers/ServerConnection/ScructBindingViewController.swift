//
//  ScructBindingViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/23.
//

import UIKit

class ScructBindingViewController: UIViewController {
    
//MARK: - Global veriable

    @IBOutlet var backGroundView: UIView!
    
    @IBOutlet weak var tfSearchWord: UITextField!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var tvReceivedJsonData: UITextView!

//MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initEvent()
    }
    
//MARK: - init
    func initView() {
        self.btnRequest.backgroundColor = baseColor
        self.btnRequest.tintColor = baseTextColor
    }
    
    //For hiding keyboard
    func initEvent() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        
        backGroundView.addGestureRecognizer(gesture)
    }
    
    //Hide keyboard
    @objc func hideKeyboard(_ :UIGestureRecognizer) {
        print("hide kayboard")
        self.view.endEditing(true)
    }
    
//MARK: - Button Event
    @IBAction func requestButtonPressed(_ sender: Any) {
        
        //API 호출
        
        self.view.endEditing(true)
    }
}
