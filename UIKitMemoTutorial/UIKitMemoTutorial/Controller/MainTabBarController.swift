//
//  MainTabBarController.swift
//  UIKitMemoTutorial
//
//  Created by 이종선 on 9/30/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memoListNavController = UINavigationController(rootViewController: MemoListViewController())
        memoListNavController.tabBarItem = UITabBarItem(title: "메모", image: UIImage(systemName: "note.text"), tag: 0)
        let settingsNavController = UINavigationController(rootViewController: SettingsViewController(style: .grouped))
        settingsNavController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gear"), tag: 1)
               
        
        viewControllers = [memoListNavController, settingsNavController]
    }
}

