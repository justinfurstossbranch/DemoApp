//
//  AppDelegate.swift
//  AasthaDemoApp
//
//  Created by Justin Furstoss on 3/18/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//
//MARK: Import Branch
import UIKit
import SnapKit
import Branch
import Firebase
import SwrveSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = ViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.becomeKey()
        self.window?.rootViewController = rootViewController
        
        //MARK: Firebase
        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
        
        //MARK:
        let config = SwrveConfig()
        config.pushResponseDelegate = self
        config.pushEnabled = true
        config.appGroupIdentifier = "group.io.branch.DemoApp"
        SwrveSDK.sharedInstance(withAppID: 31875, apiKey: "8v4vFLUGu5mbRHjVxZla", config: config)


        // Add/Remove based on Live/Test Environment
        Branch.setUseTestBranchKey(true)
        let branch = Branch.getInstance()
        // Add/Remove based on logging needs
        branch.enableLogging()
        //MARK: Branch Init Session
        registerForPushNotifications()
        branch.initSession(launchOptions: launchOptions) { (deepLinkingParams, error) in
            print("Branch Parameters")
            print(deepLinkingParams as? [String: AnyObject] ?? {})
            branch.setIdentity("1234")
            branch.setIdentity("1234email")
            if let params = deepLinkingParams {
                if let isWebOnly = params["$web_only"] as? Bool {
                    if isWebOnly {
                        // Kick User out to Safari
                    }
                } else {
                    // Handle Deep Linking Routing Logic here
                    rootViewController.branchInitParameters =  NSDictionary(dictionary: params)
                }
            }
        }
        return true
    }
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        Branch.getInstance().application(app, open: url, options: options)
//        return true
//    }
//
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        Branch.getInstance().continue(userActivity)
//        return true
//    }
    
    //MARK: Push Notifications Allowance
    func registerForPushNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
        let generalCategory = UNNotificationCategory(identifier: "GENERAL",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().delegate = self
            }
            UNUserNotificationCenter.current().setNotificationCategories([generalCategory])
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

//MARK: Firebase Messaging Delegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM Token")
        print(fcmToken)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("FCM Message")
        print(remoteMessage.appData)
    }
}

//MARK: SWRVE
extension AppDelegate: SwrvePushResponseDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Application Did Recieve")
        print(userInfo)
        Branch.getInstance().handlePushNotification(userInfo)
        let handled = SwrveSDK.didReceiveRemoteNotification(userInfo, withBackgroundCompletionHandler: { fetchResult, swrvePayload in
            print("SWRVE Payload")
            print(swrvePayload)
            // NOTE: Do not call the Swrve SDK from this context
            // Your code here to process a Swrve remote push and payload
            completionHandler(fetchResult)
        })
        
        if(!handled){
            print("Not SWRVE")
            // Your code here, it is either a non-background push received in the background or a non-Swrve remote push
            // You’ll have to process the payload on your own and call the completionHandler as normal
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Application Will Present")
        completionHandler([.alert,.badge,.sound])
    }
    
    func didReceive(_ response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("SWRVE Did Recieve Response")
        // Called when the push is interacted with. (pressed, button or dismiss)
        completionHandler()
    }
    
    func willPresent(_ notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Called when a push is received when the app is in the foreground.
        print("SWRVE Will Present")
        completionHandler([])
    }
}


