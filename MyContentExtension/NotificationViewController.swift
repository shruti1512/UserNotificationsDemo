//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Shruti Sharma on 2/20/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            
            var image: UIImage!
            do {
                let data = try Data.init(contentsOf: attachment.url)
                image = UIImage(data: data)
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            if let img = image {
                imgView.image = img
            }
            
        }
        
    }

}
