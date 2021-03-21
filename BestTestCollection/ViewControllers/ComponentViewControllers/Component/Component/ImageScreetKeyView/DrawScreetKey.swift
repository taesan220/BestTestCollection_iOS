//
//  DrawScreetKey.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/22.
//

import UIKit

class DrawScreetKey: NSObject {
    
    static let shared = DrawScreetKey()
    let textWidth = 20
    let textGap = 2
    
    func getScreetKeyImage(frame: CGRect, screetKey: String) -> UIImage? {
        
        for screetChacter in screetKey {
            
            print(screetChacter)
        }
        
        let image = drawString(frame: frame, text: screetKey)
        
        return image
    }
    
    
    func drawString(frame: CGRect, text: String) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize.init(width: frame.size.width, height: frame.size.height))

        let string = text as NSString

        let attributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
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
}

