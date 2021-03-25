//
//  Alert.swift
//  managernew2
//
//  Created by sdev-mac on 2021/03/05.
//

import UIKit

class Alert: UIAlertController, UITextFieldDelegate {


    static let shared = Alert()
    
    func createAlert(title: String?, message: String?, okString: String, completion: @escaping() -> Void) -> UIAlertController {
        
           let alert = UIAlertController(title: title,
               message: message,
               preferredStyle: .alert)
           
        let okAction = UIAlertAction(title: okString, style: .default) { (UIAlertAction) in
            completion()
        }
        alert.addAction(okAction)
        
        return alert
    }
    
    
    func createAlertWithCancel(title: String?, message: String?, okString: String, cancelString: String?, completion: @escaping() -> Void) -> UIAlertController {
        
           let alert = UIAlertController(title: title,
               message: message,
               preferredStyle: .alert)
           
        let okAction = UIAlertAction(title: okString, style: .default) { (UIAlertAction) in
            completion()
        }
        alert.addAction(okAction)

        if cancelString != nil {
            // Cancel button
            let cancel = UIAlertAction(title: cancelString!, style: .destructive, handler: { (action) -> Void in })
            
            // Add action buttons and present the Alert
            alert.addAction(cancel)

        }        
        
        return alert
    }
    
    
    //호출 식별자 리턴
    func popUpAlertWithTextField(viewController: UIViewController, withIdentifier: Int, title: String? = nil, message: String?, okString: String, cancelString: String?, textfieldText: String?, textfieldHint: String?, textfieldMaxLength: Int, completion: @escaping(String, Int) -> Void) {
                           
     
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        if title != nil {
            alert.title = title
        }
        

        // Submit button
         let submitAction = UIAlertAction(title: okString, style: .default, handler: { (action) -> Void in
            
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            let inputText = textField.text?.trimmingCharacters(in: .whitespaces)    //공백 제거
            print(inputText!)

            completion(inputText!, withIdentifier)
         })
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        
        
        if cancelString != nil {
            // Cancel button
            let cancel = UIAlertAction(title: cancelString!, style: .destructive, handler: { (action) -> Void in })
            
            // Add action buttons and present the Alert
            alert.addAction(cancel)

        }

        // Add 1 textField and customize it
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.clearButtonMode = .whileEditing
                textField.delegate = self
                textField.tag = textfieldMaxLength
                
                if textfieldText != nil {   //텍스트 필드에 텍스트 입력
                    textField.text = textfieldText
                }
                
                if textfieldHint != nil {   //텍스트 필드에 힌트 입력
                    textField.placeholder = textfieldHint!
                }
            }
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    
    func popUpAlertWithTextField(viewController: UIViewController, title: String? = nil, message: String?, okString: String, cancelString: String?, textfieldText: String?, textfieldHint: String?, textfieldMaxLength: Int, completion: @escaping(String) -> Void) {
                           
     
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        if title != nil {
            alert.title = title
        }
        

        // Submit button
         let submitAction = UIAlertAction(title: okString, style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            let inputText = textField.text?.trimmingCharacters(in: .whitespaces)    //공백 제거
            print(inputText!)

            completion(inputText!)
         })
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        
        
        if cancelString != nil {
            // Cancel button
            let cancel = UIAlertAction(title: cancelString!, style: .destructive, handler: { (action) -> Void in })
            
            // Add action buttons and present the Alert
            alert.addAction(cancel)

        }

        
        // Add 1 textField and customize it
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.clearButtonMode = .whileEditing
                textField.delegate = self
                textField.tag = textfieldMaxLength
                
                if textfieldText != nil {   //텍스트 필드에 텍스트 입력
                    textField.text = textfieldText
                }
                
                if textfieldHint != nil {   //텍스트 필드에 힌트 입력
                    textField.placeholder = textfieldHint!
                }
            }
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    
//==========================================================================================================================================
    

    
    //첨부된 ViewControlelr 파라미터로 알럿을 띄우는 메소드
    func popUpAlertWithMessageWithViewController(viewController: UIViewController, message: String, positiveButtonName: String = "OK", completion:(() -> Void)? = nil) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: positiveButtonName, style: .default, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!()
            }
        }))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    //최 상위 ViewController으로 알럿을 띄우는 메소드
    func popUpAlertWithMessage(message: String, positiveButtonName: String = "OK", completion:(() -> Void)? = nil) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: positiveButtonName, style: .default, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!()
            }
        }))
        DispatchQueue.main.async {
            
            AppDelegate.shared.topViewController().present(alert, animated: true)
        }
    }
    
    //첨부된 ViewControlelr 파라미터로 취소 가능한 알럿을 띄우는 메소드
    func popUpCancelableAlertWithMessageWithViewController(viewController: UIViewController, message: String, positiveButtonName: String = "OK", negativeButtonName: String = "Cancel", completion:((_ isCancelButtonPressed: Bool) -> Void)? = nil) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: positiveButtonName, style: .default, handler: { (UIAlertAction) in
            
            if (completion != nil) {
                completion!(true)
            }
        }))
        alert.addAction(UIAlertAction(title: negativeButtonName, style: .default, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!(false)
            }
        }))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    //최 상위 ViewController으로 취소 가능한 알럿을 띄우는 메소드
    func popUpCancelableAlertWithMessage(message: String, positiveButtonName: String = "OK", negativeButtonName: String = "Cancel", completion:((_ isCancelButtonPressed: Bool) -> Void)? = nil) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: positiveButtonName, style: .default, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!(true)
            }
        }))
        alert.addAction(UIAlertAction(title: negativeButtonName, style: .default, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!(false)
            }
        }))
        DispatchQueue.main.async {
            
            AppDelegate.shared.topViewController().present(alert, animated: true)
        }
    }
    
    //알럿 팝업 후 설정 값에 따라 앱을 종료하는 메소드
    func popUpServerErrorAlert(willTerminateApp: Bool, message messageString : String? = nil) {
        
        var message = "서버 접속 장애가 발생 하였습니다\n 잠시후 다시 시도해 주세요"
        
        if messageString != nil {
            message = messageString!
        }
        
        self.popUpAlertWithMessage(message: message) {
            if willTerminateApp {
                exit(0)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = textField.tag
        
        if (maxLength == 0) {
            maxLength = 30
        }
        
        if range.length == 1 {  //지울 길이가 1이상 (백스페이스키를 누른 경우) 글자 지워지도록 함
            return true
        }
        
        //작성된 글차 변수에 넣음
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > maxLength {
            //Todo 알럿 팝업
            
            let newPosition = textField.endOfDocument   //끝 커서 위치
            //문자 끝으로 커서 이동
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            return false
        }
        
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var maxLength = textView.tag
        
        if (maxLength == 0) {
            maxLength = 30
        }
        if range.length == 1 {  //지울 길이가 1이상 (백스페이스키를 누른 경우) 글자 지워지도록 함
            return true
        }
        
        //작성된 글차 변수에 넣음
        let newText = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        if newText.count > maxLength {
            //Todo 알럿 팝업
            
            let newPosition = textView.endOfDocument   //끝 커서 위치
            //문자 끝으로 커서 이동
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            return false
        }
        return true
    }
}
