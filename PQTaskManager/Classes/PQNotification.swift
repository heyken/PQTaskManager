//
//  Notification.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

import Foundation

struct PQNotification {
    static let NOTI_NAME = "pqTaskNoti"
    static let USER_INFO = "userInfo"
    
    static let notiName = Notification.Name(rawValue: NOTI_NAME)
    static func post(_ object:Any? = nil) {
        let userInfo:[String:Any]? = (object != nil ? [USER_INFO:object!] : nil)
        NotificationCenter.default.post(name: PQNotification.notiName,
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    static func addNoti(completion:@escaping (_ object:AnyObject?)->()) {
        NotificationCenter.default.addObserver(forName: PQNotification.notiName, object: nil, queue: nil) { noti in
            if let userInfo = noti.userInfo?[USER_INFO] as AnyObject? {
                completion(userInfo)
            } else {
                completion(noti.userInfo as AnyObject?)
            }
        }
    }
}
