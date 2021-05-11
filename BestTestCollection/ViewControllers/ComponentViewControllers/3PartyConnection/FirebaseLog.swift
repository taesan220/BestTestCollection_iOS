//
//  FirebaseLog.swift
//  BestTestCollection
//
//  Created by sdev-mac on 2021/04/07.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseLog {

    static let shared = FirebaseLog()
    
    var ref: DatabaseReference!

    var userID: String = "test_id"
    
    func sendLogToEvent() {
        
        Analytics.logEvent("login_error", parameters: getParameters())
     
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
            AnalyticsParameterMethod: "login_success"
        ])
        
        
    }
    
    //파이어베이스 Firestore Database로 로그를 전송하는 메소드
    func sendLogToFireStore() {

        let db = Firestore.firestore()

        let path = db.collection("error").document("login_error").collection(userID).document(getCurrentTime())
        path.setData(getParameters(), completion: { (error) in
            print("==========================================")
            print("isSuccess?")
            print(error ?? "sendLogToFireStore Error")
            print("==========================================")
        })
    }
    

    //파이어베이스 Realtime Database로 로그를 전송하는 메소드
    func sendLogToRealTimeDataBase() {
        
        ref = Database.database().reference()
        let parameters = getParameters()    //파라미터 생성
            
        self.ref.child("error").child("login_error").child(userID).child(getCurrentTime()).setValue(parameters)
    }
    
    //파이어베이스에 전송할 파라미터 생성
    func getParameters() -> [String: Any] {
        //앱 고유 넘버 -> 앱이 설치될때 마다 바뀜

        let iOSVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

        //현재 시간 문자 갑으로 출력
        
        let parameters = ["ios_version" : iOSVersion,
                          "device_info": "iPhone X",
                          "rs_code":"1",
                          "error_code":"104",
                          "time":getCurrentTime()] as [String : Any]
        
        return parameters
    }
    
    
    //현재 시간 문자로 출력
    func getCurrentTime(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        let currentDateStirng = formatter.string(from: Date())
        
        return currentDateStirng
    }
}
