//
//  ImagePicker.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/24.
//

import UIKit
import MobileCoreServices.UTCoreTypes

protocol ImagePickerDelegate {
    func selectedImage(image: UIImage)
    
    func deleteImage()
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //let shared = ImagePicker()
    
    var imagePickerDelegate: ImagePickerDelegate!

    func showImageAlert(target: UIViewController) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "camera", style: .default, handler: { (action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "delete", style: .default, handler: { (action: UIAlertAction) in
            //Delete Image
            if self.imagePickerDelegate != nil {
                self.imagePickerDelegate.deleteImage()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        
        target.present(alert, animated: true, completion: nil)
    }
    
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            
            DispatchQueue.main.async {
                
                AppDelegate.shared.topViewController().present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        DispatchQueue.main.async {
            
            AppDelegate.shared.topViewController().dismiss(animated: true, completion: { [self] in
                
                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
                //Setting image to your image view
                let photoImage = self.fixOrientation(img: image)
                
                print("selected Image")
                
                if imagePickerDelegate != nil {
                    imagePickerDelegate.selectedImage(image: photoImage)
                }
            })
        }
        
        

    }

    //카메라 회전 교정
    func fixOrientation(img: UIImage) -> UIImage {

        if (img.imageOrientation == .up) {

            return img
        }

        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)

        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)

        img.draw(in: rect)

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        return normalizedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
