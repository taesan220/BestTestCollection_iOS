//
//  SendingImageViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/23.
//

import UIKit
import MobileCoreServices.UTCoreTypes

class SendingImageViewController: UIViewController, ImagePickerDelegate {

    
    
//MARK: - Global veriable

    @IBOutlet weak var btnSendImage: UIButton!
    
    @IBOutlet weak var tfUploadUrl: UITextField!
    
    var imagePicker: ImagePicker!
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
//MARK: - init
    func initView() {
        self.btnSendImage.backgroundColor = baseColor
        self.btnSendImage.tintColor = baseTextColor
    }
    
//MARK: - Button Event

    @IBAction func sendImageButtonPressed(_ sender: Any) {
        
        if imagePicker == nil {
            imagePicker = ImagePicker()
            imagePicker.imagePickerDelegate = self
        }
        
        imagePicker.showImageAlert(target: self)
   
    }
    
    
    func selectedImage(image: UIImage) {
        print("이미지 선택 됨")
        SendFileData.shared.sendImage(image: image, uploadUrl: tfUploadUrl.text!)
    }
   
    

    
    func deleteImage() {
        print("이미지 삭제")
        //DeleteImage
    }
}
