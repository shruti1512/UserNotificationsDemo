//
//  ViewController.swift
//  UserNotificationsDemo
//
//  Created by Shruti Sharma on 2/20/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. REQUEST AUTHORIZATION FOR USER NOTIFICATIONS FROM USER
        /* we call the requestAuthorization method of the notification center to ask the user’s permission for using notification. We also request the ability to display alerts and play sounds. */
        
        requestNotificationAuth()
    }

    func requestNotificationAuth() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("User has granted permission for notifications.")
            } else {
                print(error)
            }
        })
    }
    
    //3. SCHEDULE NOTIFICATION
    @IBAction func scheduleNotificationButtonTapped(_ sender: Any) {
        
        scheduleNotifications(inSeconds: 5, completionHandler: { success in
            
            if success {
                
            }else {
                
            }
        })
    }
    
    //2. CREATE NOTIFICATION REQUEST
    func scheduleNotifications(inSeconds: TimeInterval, completionHandler: @escaping (_ Success: Bool) -> ()) {
       
        /* 1. Create Notification Request
        We create a request with 3 parameters:
        identifier: This is a unique identifier for our request. This identifier can be used to cancel notification requests.
        content: This is the notification content.
        trigger: This is the trigger we would like to use to trigger our notification. When the conditions of the trigger are met, iOS will display the notification.
         */
        
        guard let imageUrl = Bundle.main.url(forResource: "rick_grimes", withExtension: "gif") else {
            completionHandler(false)
            return
        }
        
        //UNNotificationTrigger: A trigger is a set of conditions that must be met for a notification to deliver.
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //UNNotificationContent: The content of the notification which includes title, subTitle, body, attachment
        let notifContent = UNMutableNotificationContent()
        notifContent.title = "New notification!"
        notifContent.subtitle = "These are great!"
        notifContent.body = "The new notification options in iOS 10 are what I've been waiting for! 👊"
        do {
            let attachment = try UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
            notifContent.attachments = [attachment]
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        //ONLY FOR EXTENSION
        notifContent.categoryIdentifier = "myNotificationCategory"

        //UNNotificationRequest
        let notifRequest = UNNotificationRequest(identifier: "myNotification", content: notifContent, trigger: notifTrigger)
        
        //2. Add the request to the notification center that manages all notifications for the app
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(notifRequest, withCompletionHandler: { error in
            if (error != nil) {
                print(error)
                completionHandler(false)
            }else {
               completionHandler(true)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

