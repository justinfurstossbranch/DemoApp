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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        let rootViewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.becomeKey()
        window?.rootViewController = rootViewController
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
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // MARK: Insert Branch.getInstance().application(app, open: url, options: options)
        print("Open URL")
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //MARK: Insert Branch.getInstance().continue(userActivity)
        print("Continue User Activity")
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //MARK: Insert Branch.getInstance().handlePushNotification(userInfo)
        print("APN User Info")
        print(userInfo)
        Branch.getInstance().handlePushNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //MARK: Push Notifications
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device Token")
        print(deviceToken.map({String(format: "%02x", $0)}).joined())
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // When app is in Foreground
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // How to process the push information
        print("Push Information")
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM Token")
        print(fcmToken)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("FCM Message")
        print(remoteMessage.appData)
//        Branch.getInstance().handlePushNotification(remoteMessage.appData)
    }
    
}


