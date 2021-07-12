//
//  AppDelegate.swift
//  rootViewControllerTest
//
//  Created by 長野史晃 on 2021/06/07.
//

import UIKit
import UserNotifications
import NotificationCenter
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    
   // var viewController: ViewController?
    
    //var alertController: UIAlertController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("アプリが起動")
        
        FirebaseApp.configure()
        

        // Override point for customization after application launch.
        
//        //Notification登録前のおまじない。テストの為、現在のノーティフケーションを削除します
//           UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
//
//           //Notification登録前のおまじない。これがないとpermissionエラーが発生するので必要です。
//           UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in if granted {print("通知許可")}
//           }
        
        
        
        

            
            
        //}
        //FCM用トークン取得
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }
        
        //APNs許可
        if #available(iOS 10.0, *) {
            
            // iOS 10 以降
                   // For iOS 10 display notification (sent via APNS)
                   UNUserNotificationCenter.current().delegate = self
            
            

                   let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                   UNUserNotificationCenter.current().requestAuthorization(
                       options: authOptions,
                       completionHandler: {_, _ in })
               } else {
                // iOS 10 より前
                   let settings: UIUserNotificationSettings =
                       UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                   application.registerUserNotificationSettings(settings)
               }
        
               application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        
        //
        
//        if let notificationOptions = launchOptions?[.remoteNotification] as? [String: AnyObject] {
//            guard let apsPart = notificationOptions["aps"] as? [String: AnyObject] else { return true }
//
//            //guard let vc = window?.rootViewController as? ViewController else { return true }
//            let text = apsPart.map { (key, value) in "\(key): \(value)" }.joined(separator: "\n")
//            //vc.payloadText = text
//            print("ペイロード\(text)")
//        }
        
        
        //以下で登録処理
        
        let content = UNMutableNotificationContent()
        
        content.title = "ローカル通知";
        content.body = "通知";
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)//５秒後
        let request = UNNotificationRequest.init(identifier: "TestNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
        center.delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        print("scene呼び出し中")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    
        print("アプリが閉じられたよ")
    }
    
    //APNsトークン取得(pusher用トークン)
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
           let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)") // この文字列を device token としてテキストボックスに貼り付ける
        
       }
    
    
    
    //apnsの情報を取得しているはずてん（呼ばれてない）
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // MARK: 04. get notification payload
        guard let apsPart = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }

       
        let text = apsPart.map { (key, value) in "\(key): \(value)" }.joined(separator: "\n")
        print("ペイロード\(text)")

    }
    
    
    
    
    //アプリ起動中に通知を受け取ると呼び出される
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("通知がきたよ")
        if #available(iOS 14.0, *) {
            print("1")
            completionHandler([[.banner, .list, .sound]])
            
            
        } else {
            print("2")
            completionHandler([[.alert, .sound]])
        }
      }

    //ポップアップ押した後に呼ばれる関数(↑の関数が呼ばれた後に呼ばれる)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
      print("3")
      // 通知の情報を取得
      let notification = response.notification

      // リモート通知かローカル通知かを判別
      //Push通知
      if notification.request.trigger is UNPushNotificationTrigger {
          print("didReceive Push Notification")
      }
      //ローカル通知
      else {
          print("didReceive Local Notification")
    
      }
    
        
        
        
        let sceneDelegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.delegate as? SceneDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KentiViewController")
        sceneDelegate?.switchViewController(viewController: viewController)
      
////            //Alertダイアログでテスト表示
      
//          let contentBody = response.notification.request.content.body
//        let alert:UIAlertController = UIAlertController(title: "受け取りました", message: contentBody, preferredStyle: UIAlertController.Style.alert)
      
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
//              (action:UIAlertAction!) -> Void in
//              print("Alert押されました")
//          }))
//          self.window?.rootViewController?.present(alert, animated: true, completion: nil)
      
      //アラート関数表示
//        alert(title: "サンプル",
//              message: "メッセージ表示")
      
//
//        guard let window = UIApplication.shared.keyWindow else { return }
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        if window.rootViewController?.presentedViewController != nil {
//            // モーダルを開いていたら閉じてから差し替え
//            window.rootViewController?.dismiss(animated: false) {
//                window.rootViewController = storyboard.instantiateInitialViewController()
//            }
//        } else {
//            // モーダルを開いていなければそのまま差し替え
//            window.rootViewController = storyboard.instantiateInitialViewController()
//        }
//
      
//      alertController = UIAlertController(title: "タイトル",
//                                 message: "メッセージ",
//                                 preferredStyle: .alert)
//      alertController.addAction(UIAlertAction(title: "OK",
//                                     style: .default,
//                                     handler: nil))
//
//      self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//
//      print("アラート表示")
      
      
      print("4")
      
        completionHandler()
      
    }

}

