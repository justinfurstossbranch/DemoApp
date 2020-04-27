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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
        branch.initSession(launchOptions: launchOptions) { (deepLinkingParams, error) in
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
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //MARK: Insert Branch.getInstance().continue(userActivity)
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //MARK: Insert Branch.getInstance().handlePushNotification(userInfo)
        Branch.getInstance().handlePushNotification(userInfo)
    }
}

