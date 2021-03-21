//
//  ScreetKeyView.swift
//  managernew2
//
//  Created by sdev-mac on 2021/03/08.
//

import UIKit

protocol ImageScreetkeyViewDelegate {
    func screetKeyTextFieldDidBeginEditing(_ textField: UITextField)
    
    func screetKeyTextFieldDidEndEditing(_ textField: UITextField)

}

class ImageScreetKeyView: UIView, CustomTextFieldDelegate {
    
//MARK: - 전역 변수
   
    var imageScreetkeyViewDelegate: ImageScreetkeyViewDelegate!
    
    @IBOutlet weak var imageScreetNumber: UIImageView!
    
    @IBOutlet weak var tfScreetNumber: CustomTextField!
    
    @IBOutlet weak var btnScreetNumberRefresh: UIButton!
    
    var sData: String = ""

    private var strArrayData = ["2", "3", "4", "5", "6", "7", "8", "9", "A", "B",
                                "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
                                "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W",
                                "X", "Y", "Z"]
    
//MARK: - 기본 메소드
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadView()  //최초 뷰 진입시 동작 수행
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()  //최초 뷰 진입시 동작 수행
    }
    
    private func loadView() {
        let nib = UINib(nibName: "ImageScreetKeyView", bundle: Bundle.main)

        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

        xibView.frame = self.bounds
           xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.addSubview(xibView)
    
        self.imageScreetNumber.backgroundColor = .white
        self.imageScreetNumber.layer.cornerRadius = 5
        self.imageScreetNumber.layer.borderWidth = 0.5
        self.imageScreetNumber.layer.borderColor = UIColor.darkGray.cgColor
        
        btnScreetNumberRefresh.layer.cornerRadius = 5

        setScreetNumber()   // 보안문자 생성
    }
    
//MARK: - 보안키 생성
    
    //보안 문자를 생성해 라벨에 입력하는 메소드
    func setScreetNumber() {
        
        sData = makeList()  //랜덤 문자 생성
        
        let screetKey = String(sData)
        
        imageScreetNumber.image = DrawScreetKey.shared.getScreetKeyImage(frame: imageScreetNumber.frame, screetKey: screetKey)
        
//        lbScreetNumber.text = sData
    }
    
    
    func makeList() -> String {
        var list:String = ""
        
        repeat {
            let random = strArrayData[Int(arc4random_uniform(UInt32(strArrayData.count)))]
            
            if !list.contains(random) {
                list.append(random)
            }
            
        } while list.count < 6
        
        return list
    }
    
//MARK: - 버튼 이벤트
    @IBAction func refreshButtonPressed(_ sender: Any) {
        self.refreshSecretKey()
    }
    
    //보안키를 refresh 하는 메소드
    func refreshSecretKey() {
        setScreetNumber()   // 보안문자 재생성
        
        tfScreetNumber.text = ""    //보안문자 입력 텍스트 필드 초기화
    }

//MARK: - 보안키 체크
    func checkTypedScreetNumber() -> Bool {
        
        if tfScreetNumber.text == sData {
            return true
        }
        
        return false
    }
    
    //텍스트 필드의 포커싱이 시작되면 호출되는 사용자 델리게이트 메소드
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if imageScreetkeyViewDelegate != nil {
            imageScreetkeyViewDelegate.screetKeyTextFieldDidBeginEditing(textField)
        }
    }
    
    //텍스트 필드의 포커싱이 종료되면 호출되는 사용자 델리게이트 메소드
    func textFieldDidEndEditing(_ textField: UITextField) {
        if imageScreetkeyViewDelegate != nil {
            imageScreetkeyViewDelegate.screetKeyTextFieldDidEndEditing(textField)
        }
    }
}
