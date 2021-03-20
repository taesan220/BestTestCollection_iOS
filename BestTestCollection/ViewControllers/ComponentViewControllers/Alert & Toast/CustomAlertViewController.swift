//
//  CustomAlertViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import UIKit

class CustomAlertViewController: UIViewController {
//MARK: - Global veriable
    @IBOutlet weak var btnNormalAlertPopUp: UIButton!
    @IBOutlet weak var btnCancalableAlertPopUp: UIButton!
    @IBOutlet weak var btnAlertWithTextFieldPopUp: UIButton!
    @IBOutlet weak var btnAlertWithViewController: UIButton!
    
    @IBOutlet weak var lbInputOnTextField: UILabel!
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setButtonColor()
    }
    
    func setButtonColor() {
        self.btnNormalAlertPopUp.backgroundColor = baseColor
        self.btnNormalAlertPopUp.tintColor = baseTextColor
        self.btnCancalableAlertPopUp.backgroundColor = baseColor
        self.btnCancalableAlertPopUp.tintColor = baseTextColor
        self.btnAlertWithTextFieldPopUp.backgroundColor = baseColor
        self.btnAlertWithTextFieldPopUp.tintColor = baseTextColor
        self.btnAlertWithViewController.backgroundColor = baseColor
        self.btnAlertWithViewController.tintColor = baseTextColor
    }
    
    
//MARK: - Custom Alert

//MARK: - Button event
    @IBAction func NormalAlertPopUpButtonPressed(_ sender: Any) {
        
        Alert.shared.popUpAlertWithMessage(message: "This is a normal Alert")
    }
    
    @IBAction func cancelAlertPopUpButtonPressed(_ sender: Any) {
        
        Alert.shared.popUpCancelableAlertWithMessage(message: "This is a cancelable Alert")
    }
    
    @IBAction func textFieldAlertPopUpButtonPressed(_ sender: Any) {
        
        let message = "This is a alert with view controller"
        Alert.shared.popUpAlertWithTextField(viewController: self, message: message, okString: "OK", cancelString: "Cancel", textfieldText: "Text", textfieldHint: "PlaceHolder", textfieldMaxLength: 20) { (inputText) in
            
            self.lbInputOnTextField.text = inputText
        }
    }
    
    @IBAction func viewControllerAlertPopUpButtonPressed(_ sender: Any) {
        //Alert.shared.popUpAlertWithMessageWithViewController(viewController: <#T##UIViewController#>, message: "This is a alert with view controller")
    }
}
