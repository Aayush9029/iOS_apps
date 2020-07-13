//
//  notification.swift
//  MudraiOS14
//
//  Created by Aayush Pokharel on 2020-07-13.
//

import Foundation
import Combine
import SwiftUI


class NotifNamager{
    
    let center = UNUserNotificationCenter.current()
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.sendNotification(after_sec_of_time: 5)
                print("Notificaion added to iOS notificaion Queue")
            } else {
                print("Notificaion Not granted")
                return
            }
        }
    }
    
    func sendNotification(after_sec_of_time: Double){
        let content = UNMutableNotificationContent()
        
        content.title = "Notification Title"
        content.body = "Notificaion Subtitle goes here"
        content.categoryIdentifier = "notif123"
        content.userInfo = ["customData": "goeshere"]
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: after_sec_of_time, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        print("notificaion Added to iOS notificaion queue")
        
    }
}

