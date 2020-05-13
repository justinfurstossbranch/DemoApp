//
//  NotificationService.swift
//  SWRVEExtension
//
//  Created by Justin Furstoss on 5/6/20.
//  Copyright © 2020 Justin Furstoss. All rights reserved.
//

import UserNotifications
import SwrveSDKCommon

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        SwrvePush.handle(request.content, withAppGroupIdentifier: "group.io.branch.DemoApp") { (content) in
            self.bestAttemptContent = content
            if let bestAttemptContent = self.bestAttemptContent, let unwrappedContentHandler = self.contentHandler {
                unwrappedContentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
