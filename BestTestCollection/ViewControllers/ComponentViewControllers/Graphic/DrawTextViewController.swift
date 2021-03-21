//
//  GraphicViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import UIKit

class DrawTextViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfText: UITextField!
    
    @IBOutlet weak var btnChangeTextToImae: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnChangeTextToImae.backgroundColor = baseColor
        btnChangeTextToImae.tintColor = baseTextColor
    }
    
    func drawString(text: String) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize.init(width: 200, height:40))

        let string = text as NSString

        let attributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),
            NSAttributedString.Key.foregroundColor : UIColor.red
            ]

        // Get the width and height that the text will occupy.
        let stringSize = string.size(withAttributes: attributes)

        // Center a rect inside of the image
        // by going half the difference to the right and down.
        string.draw(
            in: CGRect(
                x: (200 - stringSize.width) / 2,
                y: (40 - stringSize.height) / 2,
                width: stringSize.width,
                height: stringSize.height
            ),
            withAttributes: attributes
        )

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    @IBAction func changeTextToImageButtonPressed(_ sender: Any) {
        
        if tfText.text == "" {
            imageView.image = nil
            return
        }
        
        guard let image = drawString(text: tfText.text!) else { return }
        imageView.image = image
    }
}
