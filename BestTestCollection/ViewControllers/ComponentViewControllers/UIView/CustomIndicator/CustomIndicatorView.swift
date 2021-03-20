//
//  CustomIndicatorView.swift
//  IndicatorPractice
//
//  Created by sdev-mac on 2021/03/17.
//

import UIKit

class CustomIndicatorView: UIView {
    
    //MARK: - Global variables

    var backGroundView: UIView!
    
    var indicator: UIActivityIndicatorView!
    
    var testButton:UIButton!
    
    var isTest = true   //Set state - true : test Mode | false : realMode
    
    let indicatorWidth = 80
    let indicatorHeight = 80
    
    let BASE_ALPHA:CGFloat = 0.5

//MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        
        self.backGroundView.backgroundColor = .black
        self.backGroundView.alpha = BASE_ALPHA
        
        setIndicator()
        startIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Cusom initialization method
    init(frame: CGRect, backgroundColor: UIColor = UIColor.black, backGroundAlpha: CGFloat = -1, indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
        
        super.init(frame: frame)
        
        self.backGroundView = UIView(frame: frame)
        
        self.backGroundView.backgroundColor = backgroundColor
      
        self.backGroundView.alpha = backGroundAlpha
        
        if backGroundAlpha == -1 {  //If there is no initialization Data, set base alpha value
            
            self.backGroundView.alpha = BASE_ALPHA
        }

        self.addSubview(self.backGroundView)
        
        setIndicator(indicatorColor: indicatorColor, moveYPosition: moveYPosition)
        startIndicator()
    }
    
//    // Create custom indicator
//    func InitCustomIndicator(frame: CGRect, backgroundColor: UIColor = UIColor.black, backGroundAlpha: CGFloat = 0.5, indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
//        
//        self.frame = frame
//        self.backgroundColor = backgroundColor
//        self.alpha = backGroundAlpha
//        
//        setIndicator(indicatorColor: indicatorColor, moveYPosition: moveYPosition)
//        startIndicator()
//    }
    
    private func setIndicator(indicatorColor: UIColor = UIColor.white, moveYPosition: CGFloat = 0) {
        
        if self.indicator == nil {
            
            let indicatorX = (Int(self.frame.width) / 2) - (indicatorWidth / 2)
            let indicatorY = (Int(self.frame.height) / 2) - (indicatorHeight / 2)
            
            self.indicator = UIActivityIndicatorView.init(frame: CGRect(x: indicatorX, y: indicatorY + Int(moveYPosition), width: indicatorWidth, height: indicatorHeight))
            self.indicator.hidesWhenStopped = true
            self.indicator.style = .whiteLarge
            self.indicator.color = indicatorColor
            
            self.addSubview(indicator)
            
            setTestButton(buttonTextColor: indicatorColor)  //Set test button by mode
        }
    }
    
    //Set test button if it's test mode
    func setTestButton(buttonTextColor: UIColor = .white) {
        
        if isTest {
            if testButton == nil {
                
                //Align Right
                self.testButton = UIButton(frame: CGRect(x: self.frame.width - 100, y: 0, width: 100, height: 100))
                self.testButton.setTitleColor(buttonTextColor, for: .normal)
                self.testButton.setTitle("STOP", for: .normal)
                self.testButton.addTarget(self, action: #selector(stopButtonPressed(_ :)), for: .touchUpInside)
            }
            
            self.addSubview(testButton)
        }
    }
    
//MARK: - indicator control
    func startIndicator() {
        self.indicator.startAnimating()
    }
    
    func stopIndicator() {
        self.indicator.stopAnimating()
        self.removeFromSuperview()
    }

    
//MARK: - Test Button event
    @objc func stopButtonPressed(_ sender: UIButton) {
        self.indicator.stopAnimating()
        self.removeFromSuperview()
    }
}
