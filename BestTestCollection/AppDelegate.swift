//
//  AppDelegate.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/17.
//

import UIKit
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    static let shared = AppDelegate()

    let gcmMessageIDKey = "gcm.message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()  //파이어베이스 어널리틱스

        Analytics.setAnalyticsCollectionEnabled(true)
        FirebaseApp.app()?.isDataCollectionDefaultEnabled = true
        
        Messaging.messaging().delegate = self   //파이어베이스 푸시 메시지
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in
                
            })
            
        } else {
            
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // Return top view controller
    func topViewController() -> UIViewController {
        var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
        
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        
        return topController
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("didReceiveRemoteNotification message ID: \(messageID)")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("didReceiveRemoteNotification message ID: \(messageID)")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("didFailToRegisterForRemoteNotificationsWithError Error: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        Messaging.messaging().apnsToken = deviceToken
        
        InstanceID.instanceID().instanceID { (token, error) in
            if let error = error{
                print("PCPangManager FIREBASE PUSH ERROR : \(error)")
            }else if let fcmToken = token {
                
                print("PCPangManager FIREBASE PUSH TOKEN : \(fcmToken.token)")
                print("PCPangManager FIREBASE PUSH TOKEN : \(fcmToken.token)")
                
                UserDefaults.standard.setValue(fcmToken.token, forKey: "fcm_token")   //로그인 시 사용하기 위해 저장

                Messaging.messaging().subscribe(toTopic: "topic")
            }
        }
    }
    
    //엡 종료시 호출
    func applicationWillTerminate(_ application: UIApplication) {
        print("Application will terminate")
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let dataDict : [String:String] = ["token" : fcmToken!]
        NotificationCenter.default.post(name: NSNotification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
    }
}

