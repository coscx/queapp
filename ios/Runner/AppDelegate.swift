import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        UmengAnalyticsPushFlutterIos.iosInit(launchOptions, appkey:"600e1f36b3b4f6635de2a6ae", channel:"appstore", logEnabled:false, pushEnabled:true);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) } .joined()
        UserDefaults.standard.set(token, forKey: "push_device_token")
        print(token)
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
    }

    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
        super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
        
    }
    // If you need to handle Push clicks, use the following code
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        UmengAnalyticsPushFlutterIos.handleMessagePush(userInfo)
        completionHandler()
    }

}
