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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootViewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.becomeKey()
        window?.rootViewController = rootViewController
        //MARK: Insert Branch Init
        // Within Branch Init call a function through the above initialized Root View Controller to Deep Link Data and pass in the params for viewing. It is within this init that you can direct your rootViewController to present other views.
        //For this case, we are just going to call the rootViewController's mainView.setCanonicalUrl and pass all of the link parameters
        
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //MARK: Insert Branch .application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //MARK: Insert Branch .continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //MARK: Insert Branch .handlePushNotification(userInfo)
    }
}

