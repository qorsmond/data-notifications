import Foundation
import Capacitor

import FirebaseCore
import FirebaseMessaging
import FirebaseInstallations

@objc(datanotificationPlugin)
public class datanotificationPlugin: CAPPlugin, MessagingDelegate {
    // private let implementation = datanotification()

    // @objc func echo(_ call: CAPPluginCall) {
    //     let value = call.getString("value") ?? ""
    //     call.resolve([
    //         "value": implementation.echo(value)
    //     ])
    // }

    private var notificationDelegateHandler = FirebasePushNotificationsHandler()
    private var savedRegisterCall: CAPPluginCall? = nil;
   // public var registered: Bool = false;
    public var registered: Bool = true;
    public override func load() {
        if (FirebaseApp.app() == nil) {
            FirebaseApp.configure();
        }
        Messaging.messaging().delegate = self
        self.notificationDelegateHandler.plugin = self;
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveRemoteNotification(notification:)), name: Notification.Name.init("didReceiveRemoteNotification"), object: nil)
    }

    @objc public func didReceiveRemoteNotification(notification: NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let completionHandler = notification.object as! (UIBackgroundFetchResult) -> Void
        self.notificationDelegateHandler.didReceiveRemoteNotification(userInfo: userInfo, fetchCompletionHandler: completionHandler)
    }

    // @objc func onDataMessage(_ call: CAPPluginCall) {
    //     // let latitude = call.getString("latitude")
    //     // let longitude = call.getNumber("longitude")

    //     // more logic

    //     call.resolve()
    // }
}
