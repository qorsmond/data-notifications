import Capacitor
import UserNotifications

import FirebaseMessaging

public class datanotificationsHandler: NSObject, NotificationHandlerProtocol {
    
    public var plugin: datanotification?;
    
    private var notificationStack: NSMutableArray?;
    
    // Tells the app that a remote notification arrived that indicates there is data to be fetched.
    // Called when a message arrives in the foreground and remote notifications permission has been granted
    public func didReceiveRemoteNotification(userInfo: NSDictionary, fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let mutableUserInfo = userInfo.mutableCopy() as! NSMutableDictionary
        Messaging.messaging().appDidReceiveMessage(userInfo as! [AnyHashable : Any])
        let aps = mutableUserInfo.object(forKey: "aps") as! NSDictionary
        var contentAvailable = false
        let state = UIApplication.shared.applicationState;
        if(aps.object(forKey: "alert") != nil) {
            contentAvailable = aps.object(forKey: "content-available") as? String == "1";
            mutableUserInfo.setValue("notification", forKey: "messageType");
            if(state == .background && !contentAvailable) {
                mutableUserInfo.setValue("background", forKey: "tap")
            }
        } else {
            mutableUserInfo.setValue("data", forKey: "messageType");
        }
        print("didReceiveRemoteNotification:", mutableUserInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
        if(state == .background || !contentAvailable) {
            self.sendNotification(userInfo: mutableUserInfo)
        }
    }
    

    
    func sendNotification(userInfo: NSDictionary) {
        if(self.plugin!.registered) {
            self.plugin?.notifyListeners("message", data: (userInfo as! [String : Any]))
        } else {
            if(self.notificationStack == nil) {
                self.notificationStack = NSMutableArray.init();
            }
            self.notificationStack!.add(userInfo)
            
            if(self.notificationStack!.count >= 20) {
                self.notificationStack!.removeLastObject()
            }
        }
    }
}
