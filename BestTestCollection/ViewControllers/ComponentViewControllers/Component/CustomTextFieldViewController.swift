//
//  CustomTextFieldViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/21.
//

import UIKit

class CustomTextFieldViewController: UIViewController {
    
//MARK: - Global veriable
    @IBOutlet weak var customTextField: CustomTextField!
    
    @IBOutlet var backgroundView: UIView!

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardHideEvent()
    }

    func setKeyboardHideEvent() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTouchEvent))
        
        backgroundView.addGestureRecognizer(gesture)
    }
    
    @objc func backgroundTouchEvent() {
        self.view.endEditing(true)  //키보드 숨김
    }

    
}
