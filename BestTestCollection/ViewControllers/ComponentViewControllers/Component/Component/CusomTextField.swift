//
//  CusomTextField.swift
//  managernew2
//
//  Created by sdev-mac on 2021/03/10.
//

import UIKit

protocol CustomTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

class CustomTextField: UITextField, UITextFieldDelegate {
    
    var customTextFieldDelegate: CustomTextFieldDelegate!
    
    @IBInspectable var maxLength: Int = 0
    
    static let MAX_TEXTFIELD_LENGTH = 30    //maxLength 값을 적용하지 않은, 최대 입력 가능한 문자 수 초기값 지정
        
    var maxTextFieldLength = MAX_TEXTFIELD_LENGTH    //최대 입력 가능한 문자 수 지정
    
    var isMaxLengthCustomized: Bool = false     //최대 입력 가능한 문자수 가 설정 되었는지 여부 적용 변수
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.delegate = self
        self.layer.borderColor = UIColor.lightGray.cgColor  //초기 값 지정
    }

    //텍스트 필드에 포커싱이 맞춰지면 호출됨
    func textFieldDidBeginEditing(_ textField: UITextField) {
                
        guard let focusBorderColor = self.value(forKey: "focusBorderColor") as? UIColor else { return }
        textField.layer.borderColor = focusBorderColor.cgColor  //테두리 색변경
        
        if self.customTextFieldDelegate != nil {
            customTextFieldDelegate.textFieldDidBeginEditing(textField)
        }
    }
    
    //텍스트 필드에 포커싱이 없어지면 호출됨
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard (self.value(forKey: "borderColor") as? UIColor) != nil else { return }

        textField.layer.borderColor = borderColor?.cgColor   //테두리 원래대로 변경
        
        if self.customTextFieldDelegate != nil {
            customTextFieldDelegate.textFieldDidEndEditing(textField)
        }
    }
    
    //이 메소드가 있어야 User Defined Runtime Attributes에 컬러 값이 제대로 적용됨 (cgColor를 적용해야 되서 그런가봄)
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    //이 메소드가 있어야 User Defined Runtime Attributes에 컬러 값이 제대로 적용됨 (cgColor를 적용해야 되서 그런가봄)
    @IBInspectable var focusBorderColor: UIColor? {
        didSet {
            layer.borderColor = focusBorderColor?.cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  !isMaxLengthCustomized && maxLength != 0 {
            self.maxTextFieldLength = maxLength
            isMaxLengthCustomized = true
        }
        
        if range.length == 1 {  //지울 길이가 1이상 (백스페이스키를 누른 경우) 글자 지워지도록 함
            return true
        }
        
        //작성된 글차 변수에 넣음
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > maxTextFieldLength {
            //Todo 알럿 팝업
            
            let newPosition = textField.endOfDocument   //끝 커서 위치
            //문자 끝으로 커서 이동
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            return false
        }
        
        return true
    }
}
