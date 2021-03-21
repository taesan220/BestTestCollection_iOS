//
//  ScreetKeyViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import UIKit

class ScreetKeyViewController: UIViewController, CustomTextFieldDelegate {

//MARK: - Global veriable

    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var lbScreetKeyCheckResult: UILabel!
    
    @IBOutlet weak var textScreetKeyContainerView: UIView!
    var screetKeyView: ScreetKeyView!

    @IBOutlet weak var imageScreetKeyContainerView: UIView!
    var imageScreetKeyView: ImageScreetKeyView!
    
    @IBOutlet weak var btnCheckTextScreetKey: UIButton!

    @IBOutlet weak var btnCheckImageScreetKey: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
        setKeyboardHideEvent()
        
        self.screetKeyView.tfScreetNumber.customTextFieldDelegate = self
        
        self.imageScreetKeyView.tfScreetNumber.customTextFieldDelegate = self
    }

//MARK: - init

    func initView () {
        self.screetKeyView = ScreetKeyView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: textScreetKeyContainerView.frame.size.height))
        
        self.textScreetKeyContainerView.addSubview(screetKeyView)
        
        self.imageScreetKeyView = ImageScreetKeyView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: imageScreetKeyContainerView.frame.size.height))
        
        self.imageScreetKeyContainerView.addSubview(imageScreetKeyView)
        
        btnCheckTextScreetKey.backgroundColor = baseColor
        btnCheckTextScreetKey.tintColor = baseTextColor
        btnCheckImageScreetKey.backgroundColor = baseColor
        btnCheckImageScreetKey.tintColor = baseTextColor
    }
    
    func setKeyboardHideEvent() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTouchEvent))
        
        backgroundView.addGestureRecognizer(gesture)
    }
    
    @objc func backgroundTouchEvent() {
        self.view.endEditing(true)  //키보드 숨김
    }
    
//MARK: - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text edit start")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text edit end")
    }
    
//MARK: - Button Event
    @IBAction func checkTextScreetButtonPressed(_ sender: Any) {
        if self.screetKeyView.checkTypedScreetNumber() {
            lbScreetKeyCheckResult.text = "Correct screet key"
            lbScreetKeyCheckResult.textColor = .black
        } else {
            lbScreetKeyCheckResult.text = "Wrong screet key"
            lbScreetKeyCheckResult.textColor = .red
        }
    }
    
    @IBAction func checkImageScreetButtonPressed(_ sender: Any) {
        if self.imageScreetKeyView.checkTypedScreetNumber() {
            lbScreetKeyCheckResult.text = "Correct screet key"
            lbScreetKeyCheckResult.textColor = .black
        } else {
            lbScreetKeyCheckResult.text = "Wrong screet key"
            lbScreetKeyCheckResult.textColor = .red
        }
    }
    
}
