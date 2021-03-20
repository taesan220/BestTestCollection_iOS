//
//  CustomIndicator.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import UIKit

class CustomIndicatorViewController: UIViewController {
//MARK: - Global veriable
    @IBOutlet weak var btnIndicatorCall: UIButton!
    
    var indicator: CustomIndicatorView!
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnIndicatorCall.backgroundColor = baseColor
        self.btnIndicatorCall.tintColor = baseTextColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
//MARK: - Custom Indicator
    
    // Set indicator on top ViewController
    func startIndicator(indicatorColor: UIColor = .white, backGroundAlpha: CGFloat = 0.5) {
        indicator = CustomIndicatorView(frame: self.view.frame, backGroundAlpha: backGroundAlpha, indicatorColor: indicatorColor, moveYPosition: 0)

        
        let topViewController = AppDelegate.shared.topViewController()
        
        topViewController.view.addSubview(indicator)
        
        indicator.startIndicator()
    }

    //Finish indicator
    func stopIndicator() {
        
        if indicator != nil {
            indicator.stopIndicator()
            
            indicator = nil
        }
    }
    
//MARK: - Button event
    @IBAction func IndicatorCallButtonPressed(_ sender: Any) {
        self.startIndicator(indicatorColor: .red, backGroundAlpha: 0.1)   //Show Indicator
    }
}
