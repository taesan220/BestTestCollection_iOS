//
//  CustomButtonViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/17.
//

import UIKit

class CustomButtonViewController: UIViewController {

    @IBOutlet weak var customButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        customButton.backgroundColor = baseColor
//        customButton.tintColor = baseTextColor
    }
    @IBAction func customButtonPressed(_ sender: UIButton) {
        
        print("Button Pressed")
    }
    
    @IBAction func cencelEnableFalseButtonPressed(_ sender: Any) {
        self.customButton.isEnabled = true
    }
}
