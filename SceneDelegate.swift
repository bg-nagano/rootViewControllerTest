//
//  SceneDelegate.swift
//  rootViewControllerTest
//
//  Created by 長野史晃 on 2021/06/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        print("sceneが呼ばれたよ")
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       // guard let _ = (scene as? UIWindowScene) else { return }
//        guard let scen = (scene as? UIWindowScene) else { return }
//        
//        //初回画面呼び出し
//        window = UIWindow(windowScene: scen)
//        window!.backgroundColor = .white
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let topviewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
//        window!.rootViewController = topviewController
//        window!.makeKeyAndVisible()

        
        
       // if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
           // appDelegate.window = window
     //   }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        print("sceneが閉じられるよ")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        print("sceneがactiveになったよ")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneがinactiveになったよ")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneがforegroundにきたよ")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
       
        print("sceneがbackgroundになったよ")
    }

    //シーン遷移関数
    func switchViewController(viewController: UIViewController) {
        
        print("シーン遷移関数")
        
        print("\(viewController)に遷移")
        UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window?.rootViewController = viewController
            
            
            UIView.setAnimationsEnabled(oldState)
        }, completion: nil)
    }

}

