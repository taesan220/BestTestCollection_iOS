//
//  CustomButton.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/21.
//

import UIKit

class CustomButton: UIButton {
    
//MARK: - Global veriable
    var backgroundButtonColor: UIColor?
    var buttonTextColor: UIColor?
    
    var highLightedColor: UIColor?
    
    var isBlockable: Bool = false
    var blockColor: UIColor?
        
    override var isEnabled: Bool {
        didSet {
           setButtonEnable(isEnable: isEnabled)
        }
    }

//MARK: - init
    override func awakeFromNib() {
       super.awakeFromNib()
        
        self.backgroundButtonColor = self.backgroundColor

        self.buttonTextColor = self.tintColor
        
        self.addTarget(self, action: #selector(self.pressesBegin(_ :)), for: [.touchDown])
        
        self.addTarget(self, action: #selector(self.pressesEnd(_ :)), for: [.touchUpInside])

        self.addTarget(self, action: #selector(self.dragInside(_ :)), for: [.touchDragInside])
        self.addTarget(self, action: #selector(self.dragOutside(_ :)), for: [.touchDragOutside])
    }

//MARK: - Setting
    //Set button Enable state
    func setButtonEnable(isEnable: Bool) {
        if isEnable {
            self.backgroundColor = backgroundButtonColor
        } else {
            self.backgroundColor = blockColor
        }
    }

//MARK: - Touch Event
    
    //Button touchDown event
    @objc func pressesBegin(_ sender: UIButton) {
        print("pressBegan")
        
        if (highLightedColor != nil) {
            self.backgroundColor = highLightedColor
        }
    }
    
    //Button touchUpInside event
    @objc func pressesEnd(_ sender: UIButton) {
        print("pressEnded")
        self.backgroundColor = backgroundButtonColor
        
        if self.isBlockable {
            self.isEnabled = false
            setButtonEnable(isEnable: false)
        }
    }

    //Button drag outside event
    @objc func dragOutside(_ sender: UIButton) {
        
        self.backgroundColor = self.backgroundButtonColor
        self.tintColor = self.buttonTextColor
    }
    
    //Button drag inside event
    @objc func dragInside(_ sender: UIButton) {
        if (highLightedColor != nil) {
            self.backgroundColor = highLightedColor
        }
    }
    
//MARK: - Attributes Inspector
    //Attributes Inspector에 설정 항목 나타남
    @IBInspectable var highLightColor: UIColor? {
        didSet {
            self.highLightedColor = highLightColor
        }
    }
    
    //Attributes Inspector에 설정 항목 나타남 (Default 값을 정해야 함)
    @IBInspectable var isBlockableButton: Bool = false {
        didSet {
            self.isBlockable = isBlockableButton
        }
    }
    
    //Attributes Inspector에 설정 항목 나타남
    @IBInspectable var buttonBlockColor: UIColor = UIColor.lightGray {
        didSet {
            self.blockColor = buttonBlockColor
        }
    }
}
