//
//  KentiViewController.swift
//  rootViewControllerTest
//
//  Created by 長野史晃 on 2021/06/18.
//

import UIKit

class KentiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Kentt¥iiewController呼び出し")
        
        
        
        view.backgroundColor = .red
        let backButton = UIButton()
        backButton.frame.size = CGSize(width: 200, height: 100)
        backButton.center = view.center
        backButton.backgroundColor = .yellow
        backButton.setTitle("Back Button", for: .normal)
        backButton.addTarget(self, action: #selector(switchToFirst(sender:)), for:.touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc func switchToFirst(sender: UIButton) {
        print("Nextボタンが押されたよ")
        let sceneDelegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.delegate as? SceneDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    StoryboardIDをwithIdentifierで指定します
        let viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        sceneDelegate?.switchViewController(viewController: viewController)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
