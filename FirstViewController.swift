//
//  ViewController.swift
//  rootViewControllerTest
//
//  Created by 長野史晃 on 2021/06/07.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("FirstViewController呼び出し")
        
        //        ViewControllerの背景色をわかりやすく変えてます
                view.backgroundColor = .systemTeal
        //        UIButtonをコードベースで作成してるだけです
                let switchButton = UIButton()
                switchButton.frame.size = CGSize(width: 200, height: 100)
                switchButton.center = view.center
                switchButton.backgroundColor = .lightGray
                switchButton.setTitle("Next Button", for: .normal)
                switchButton.addTarget(self, action: #selector(switchToSecond(sender:)), for:.touchUpInside)
                view.addSubview(switchButton)
    }

    @objc func switchToSecond(sender: UIButton) {
        print("Nextボタンが押されたよ")
        let sceneDelegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.delegate as? SceneDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    StoryboardIDをwithIdentifierで指定します
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        sceneDelegate?.switchViewController(viewController: viewController)
    }

}

