//
//  sendFileData.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/24.
//

import UIKit

class SendFileData {
    
    static let shared = SendFileData()
    
    //var serverURL = ""
    
    func sendImage(image: UIImage, uploadUrl: String) {
        print("Send image to server")
        self.HITtheSERVER(imageData: image.pngData()!, toUrl: uploadUrl)
    }
    
    func HITtheSERVER(imageData:Data, toUrl url:String) {
             let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMdd_HHmmss"
                      let stringOfDateTimeStamp = formatter.string(from: Date())
               //        print("Date time stamp String: \(stringOfDateTimeStamp)")
                let remoteName = "IMG_\(stringOfDateTimeStamp)"+".png"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        let fname = remoteName
        let mimetype = "image/png"

        body.append("--\(boundary)\r\n".data(
            using: String.Encoding.utf8,
        allowLossyConversion: false)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(
            using: String.Encoding.utf8,
        allowLossyConversion: false)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("Content-Disposition:form-data; name=\"myFile\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)

        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)

        body.append(imageData)
        body.append("\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8,allowLossyConversion: false)!)
        request.setValue(String(body.count), forHTTPHeaderField: "Content-Length")

        request.httpBody = body


        let session = URLSession.shared

        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in

            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }

            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString as Any)

        }

        task.resume()
    }
    
    func generateBoundaryString() -> String
       {
        return "Boundary-\(NSUUID().uuidString)"
       }
}
